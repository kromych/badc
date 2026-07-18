
vla_scope_reclaim_loop.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2060, %rsp           # imm = 0x2060
               	leaq	-0x50(%rbp), %r10
               	movq	%r10, (%r10)
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	movl	%eax, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %rax
               	movq	%rax, -0x38(%rbp)
               	movl	$0x40, %eax
               	movl	%eax, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rax
               	shlq	$0x2, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	%rax, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x50(%rbp), %r11
               	movq	(%r11), %rax
               	subq	%r10, %rax
               	leaq	-0x2000(%r11), %r10
               	cmpq	%r10, %rax
               	jae	<addr>
               	ud2
               	movq	%rax, (%r11)
               	movq	%rax, -0x20(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x30(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x30(%rbp), %rax
               	movl	%eax, (%rcx,%rax,4)
               	movslq	-0x30(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x30(%rbp)
               	movslq	-0x30(%rbp), %rax
               	movslq	-0x18(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jl	<addr>
               	movq	-0x8(%rbp), %rdx
               	movq	-0x20(%rbp), %rax
               	movslq	-0x10(%rbp), %rcx
               	andq	$0x3f, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	addq	%rdx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, -0x50(%rbp)
               	movslq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x40(%rbp)
               	movl	%eax, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x40(%rbp), %rax
               	movslq	-0x48(%rbp), %rcx
               	andq	$0x3f, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x40(%rbp)
               	movslq	-0x48(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x48(%rbp)
               	movslq	-0x48(%rbp), %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jl	<addr>
               	movq	-0x8(%rbp), %rax
               	movq	-0x40(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x2058(%rbp)
               	movq	-0x2058(%rbp), %rax
               	movslq	%eax, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	%rax, -0x2058(%rbp)
               	jmp	<addr>
