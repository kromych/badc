
attribute_cleanup.x64:	file format elf64-x86-64

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
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, -0x18(%rbp)
               	movl	$0x2, -0x10(%rbp)
               	movl	$0x3, -0x8(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	$0x3, (%rax,%rcx,4)
               	movl	-0x10(%rbp), %edx
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%edx, (%rax,%rcx,4)
               	movl	-0x18(%rbp), %edx
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%edx, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0x0, -0x8(%rbp)
               	movl	<rip>, %esi # <addr>
               	movl	$0x0, <rip> # <addr>
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, <rip> # <addr>
               	movl	$0x2bc, (%rdx,%rcx,4)   # imm = 0x2BC
               	cmpl	$0x1, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2bc, %ecx            # imm = 0x2BC
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x32, -0x18(%rbp)
               	leaq	<rip>, %rsi # <addr>
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	%rax, %rdi
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, <rip> # <addr>
               	movl	%edi, (%rdx,%rcx,4)
               	jmp	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	-0x8(%rbp), %edi
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, <rip> # <addr>
               	movl	%edi, (%rsi,%rcx,4)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movl	-0x18(%rbp), %ecx
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%ecx, (%rdx,%rax,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x32, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0xa, -0x18(%rbp)
               	movl	$0xb, -0x10(%rbp)
               	movl	$0xc, -0x8(%rbp)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	$0xc, (%rax,%rcx,4)
               	movl	-0x10(%rbp), %edx
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%edx, (%rax,%rcx,4)
               	movl	-0x18(%rbp), %edx
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%edx, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xc, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0xa, -0x18(%rbp)
               	movl	$0xb, -0x10(%rbp)
               	movl	$0xc, -0x8(%rbp)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	$0xc, (%rax,%rcx,4)
               	movl	-0x10(%rbp), %edx
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%edx, (%rax,%rcx,4)
               	movl	-0x18(%rbp), %edx
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%edx, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xc, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x28, -0x20(%rbp)
               	movl	$0x29, -0x8(%rbp)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	$0x29, (%rax,%rcx,4)
               	movl	-0x20(%rbp), %edx
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%edx, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x29, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x28, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x28, -0x20(%rbp)
               	movl	$0x29, -0x8(%rbp)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	$0x29, (%rax,%rcx,4)
               	movl	-0x20(%rbp), %edx
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%edx, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x29, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x28, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x14, -0x18(%rbp)
               	movl	$0x15, -0x10(%rbp)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	$0x15, (%rax,%rcx,4)
               	movl	-0x18(%rbp), %edx
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%edx, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x15, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x14, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	$0x0, <rip> # <addr>
               	movl	$0x14, -0x18(%rbp)
               	movl	$0x15, -0x10(%rbp)
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	$0x15, (%rax,%rcx,4)
               	movl	-0x18(%rbp), %edx
               	movslq	<rip>, %rcx # <addr>
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%edx, (%rax,%rcx,4)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %ecx
               	leaq	<rip>, %rdx # <addr>
               	movslq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rsi
               	movl	%esi, <rip> # <addr>
               	movl	%ecx, (%rdx,%rax,4)
               	jmp	<addr>
