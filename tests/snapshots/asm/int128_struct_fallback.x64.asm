
int128_struct_fallback.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<rt>:
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x18, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	$-0x1, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	(%r12,%rax), %rbx
               	cmpq	%r12, %rbx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	testq	%rbx, %rbx
               	jne	<addr>
               	cmpl	$0x1, %r12d
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, 0x10(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	cmpq	%rax, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	movq	0x10(%rsp), %rcx
               	subq	%rax, %rcx
               	cmpq	$-0x1, %rdx
               	jne	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	xorq	$-0x1, %rax
               	incq	%rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	decq	%rcx
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	shlq	$0x24, %rax
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	callq	<addr>
               	sarq	$0x4, %rax
               	movabsq	$-0x800000000000000, %r11 # imm = 0xF800000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, 0x18(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	0x18(%rsp), %rbx
               	jne	<addr>
               	cmpq	%rax, %r12
               	jne	<addr>
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x9, %edi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	jae	<addr>
               	movl	$0x9, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	%rax, %rbx
               	jae	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	addq	$0x18, %rsp
               	retq
