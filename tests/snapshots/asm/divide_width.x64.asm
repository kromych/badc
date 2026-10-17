
divide_width.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<wide_quot>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	retq

<wide_rem>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rax
               	retq

<wide_quot_ll>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	retq

<compound_wide>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	retq

<low_words>:
               	movq	%rdi, %rax
               	shrq	$0x1f, %rax
               	andq	$0x7, %rsi
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	addq	%rsi, %rcx
               	xorl	%edx, %edx
               	divl	%ecx
               	movl	$0xaaaaaaab, %ecx       # imm = 0xAAAAAAAB
               	imulq	%rax, %rcx
               	shrq	$0x21, %rcx
               	cmpl	$0x1, %eax
               	seta	%al
               	movzbq	%al, %rax
               	addq	%rcx, %rax
               	retq

<rem_bounded>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	shrq	$0x3d, %rax
               	addq	%rdi, %rax
               	sarq	$0x3, %rax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movq	%rdi, %rax
               	subq	%rcx, %rax
               	retq

<urem_bounded>:
               	movl	$0x5, %eax
               	retq

<pair>:
               	movl	%edi, %eax
               	cltd
               	idivl	%esi
               	movslq	%eax, %rcx
               	imulq	%rsi, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movslq	%edx, %rax
               	imulq	$0x3e8, %rcx, %rdx      # imm = 0x3E8
               	addq	%rax, %rdx
               	imulq	%rsi, %rcx
               	addq	%rcx, %rax
               	cmpl	%edi, %eax
               	sete	%al
               	movzbq	%al, %rax
               	addq	%rdx, %rax
               	retq

<two_widths>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rcx
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rdx, %rax
               	shrq	%rax
               	movl	%ecx, %ecx
               	movl	$0xaaaaaaab, %r11d      # imm = 0xAAAAAAAB
               	imulq	%r11, %rcx
               	shrq	$0x21, %rcx
               	shlq	%rcx
               	xorq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ebx
               	movl	0x4(%rax), %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rsi
               	callq	<addr>
               	cmpq	$0x55555556, %rax       # imm = 0x55555556
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movq	$-0xd, %rdi
               	callq	<addr>
               	cmpl	$-0x5, %eax
               	jne	<addr>
               	movl	$0xd, %edi
               	callq	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	callq	<addr>
               	xorq	$0x5, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %edi
               	movl	0xc(%rax), %esi
               	callq	<addr>
               	cmpq	$-0x7cc, %rax           # imm = 0xF834
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	0x10(%rax), %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movabsq	$-0x476db6da51, %r11    # imm = 0xFFFFFFB8924925AF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0xc(%rax), %edi
               	shlq	%rdi
               	movl	0x8(%rax), %eax
               	leaq	-0xa(%rax), %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movabsq	$0x55555555fffffff5, %r11 # imm = 0x55555555FFFFFFF5
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
