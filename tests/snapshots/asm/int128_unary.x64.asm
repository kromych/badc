
int128_unary.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	xorl	%eax, %eax
               	leaq	-0x70(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rcx
               	movq	%rcx, %rsi
               	shlq	$0x24, %rsi
               	leaq	-0x60(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	xorq	$0x0, %rsi
               	orq	$0x0, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	0x8(%rcx), %rcx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	leaq	(%rsi), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	xorq	$0x0, %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x8(%rax), %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	(%rdx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rcx
               	cmpq	$0x0, (%rcx)
               	movq	0x8(%rcx), %rcx
               	jne	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x8, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	(%rdx), %rcx
               	xorl	%edx, %edx
               	testq	%rcx, %rcx
               	seta	%r8b
               	movzbq	%r8b, %r8
               	movq	%rdx, %rdi
               	subq	%rcx, %rdi
               	movq	%rdx, %rsi
               	subq	%r8, %rsi
               	movq	%rsi, %r8
               	sarq	$0x4, %r8
               	movq	%rdi, %rcx
               	shrq	$0x4, %rcx
               	movq	%rsi, %r9
               	shlq	$0x3c, %r9
               	orq	%rcx, %r9
               	movq	$-0x1, %rcx
               	cmpq	%rcx, %r9
               	jne	<addr>
               	cmpl	%ecx, %r8d
               	je	<addr>
               	movl	$0x9, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rdi, %rdi
               	seta	%sil
               	movzbq	%sil, %rsi
               	andq	%rsi, %rax
               	orq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	leave
               	retq
               	movq	%rdx, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
