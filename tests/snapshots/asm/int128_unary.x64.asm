
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
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x24, %rdx
               	leaq	-0x60(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	0x8(%rcx), %rdx
               	movq	%rax, %rsi
               	subq	%rdx, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	movq	%rsi, %rdx
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	cmpq	$0x0, 0x8(%rcx)
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	cmpq	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x1, %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	cmpq	$0x0, 0x8(%rax)
               	je	<addr>
               	cmpq	$0x0, 0x8(%rax)
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
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
               	movq	(%rdx), %rdx
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	%rcx, %rdx
               	subq	%rsi, %rdx
               	movq	%rdx, %r8
               	sarq	$0x4, %r8
               	movq	%rdi, %rsi
               	shrq	$0x4, %rsi
               	movq	%rdx, %r9
               	shlq	$0x3c, %r9
               	orq	%rsi, %r9
               	movq	$-0x1, %rsi
               	cmpq	%rsi, %r9
               	jne	<addr>
               	cmpl	%esi, %r8d
               	je	<addr>
               	movl	$0x9, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	leave
               	retq
               	movq	0x8(%rax), %rax
               	cmpq	%rdx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rdi, %rdi
               	seta	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	orq	%rsi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	%rcx, %rsi
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
