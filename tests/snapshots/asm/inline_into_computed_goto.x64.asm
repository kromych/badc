
inline_into_computed_goto.x64:	file format elf64-x86-64

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

<interp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x40(%rbp)
               	movq	%rdi, -0x50(%rbp)
               	movq	%rsi, -0x40(%rbp)
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x8(%rax)
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x10(%rax)
               	movq	%rcx, -0x28(%rbp)
               	movl	%ecx, -0x20(%rbp)
               	movq	-0x50(%rbp), %rcx
               	movl	$0x1, %edx
               	movl	%edx, -0x20(%rbp)
               	addq	$0x0, %rcx
               	movslq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movq	-0x28(%rbp), %rdi
               	movq	-0x40(%rbp), %rdx
               	movq	-0x50(%rbp), %rsi
               	movslq	-0x20(%rbp), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, -0x20(%rbp)
               	movslq	(%rsi,%rcx,4), %rcx
               	jmp	<addr>
               	addq	%rdi, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x50(%rbp), %rdx
               	movslq	-0x20(%rbp), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x20(%rbp)
               	movslq	(%rdx,%rcx,4), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movq	-0x28(%rbp), %rcx
               	addq	%rcx, %rcx
               	movq	%rcx, -0x28(%rbp)
               	movq	-0x50(%rbp), %rdx
               	movslq	-0x20(%rbp), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x20(%rbp)
               	movslq	(%rdx,%rcx,4), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movq	-0x28(%rbp), %rax
               	leave
               	retq
               	movq	(%rdx,%rcx,8), %rcx
               	andq	$-0x4, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x38(%rbp), %rsi
               	movl	$0x67, %eax
               	movq	%rax, (%rsi)
               	movl	$0xc9, %eax
               	movq	%rax, 0x8(%rsi)
               	movl	$0x12c, %eax            # imm = 0x12C
               	movq	%rax, 0x10(%rsi)
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	callq	<addr>
               	cmpq	$0x384, %rax            # imm = 0x384
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
