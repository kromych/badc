
vla_large_runtime.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0x1, %eax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	movq	%rax, %rdx
               	shlq	$0x12, %rdx
               	movq	%rdx, %rax
               	shlq	$0x2, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x1, %esi
               	movl	%esi, (%rcx,%rax,4)
               	incq	%rax
               	cmpq	%rdx, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movslq	(%rcx,%rax,4), %rdi
               	addq	%rdi, %rsi
               	incq	%rax
               	cmpq	%rdx, %rax
               	jl	<addr>
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	leaq	-0x20(%rbp), %rsp
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
