
switch_jump_table_phi_join.x64:	file format elf64-x86-64

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

<chain>:
               	movslq	%edi, %rdi
               	cmpq	$0xc, %rdi
               	jae	<addr>
               	leaq	<rip>, %r11
               	movq	(%r11,%rdi,8), %r10
               	jmpq	*%r10
               	incq	%rsi
               	leaq	0x2(%rsi), %rdx
               	addq	%rdx, %rsi
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rsi
               	addq	%rsi, %rdx
               	shlq	%rsi
               	decq	%rdx
               	addq	$0x7, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x1f, %rsi, %rax
               	addq	%rdx, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rdx
               	jmp	<addr>
               	movl	$0xd, %esi
               	movl	$0x11, %edx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rax, %rax
               	movabsq	$-0x2, %rbx
               	jmp	<addr>
               	movabsq	$-0x1, %r12
               	xorq	%rdx, %rdx
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x1, %edx
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x2, %edx
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	xorq	%r12, %r12
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x1, %edx
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x2, %edx
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x1, %r12d
               	xorq	%rdx, %rdx
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x1, %edx
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x2, %edx
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x2, %r12d
               	xorq	%rdx, %rdx
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x1, %edx
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movl	$0x2, %edx
               	imulq	$0x21, %rax, %r13
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	addq	%r13, %rax
               	movslq	%ebx, %rcx
               	leaq	0x1(%rcx), %rbx
               	cmpl	$0xe, %ebx
               	jl	<addr>
               	movabsq	$-0x2eb506b7b9cbd8a0, %r11 # imm = 0xD14AF94846342760
               	cmpq	%r11, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
