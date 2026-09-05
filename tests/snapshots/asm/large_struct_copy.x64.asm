
large_struct_copy.x64:	file format elf64-x86-64

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
               	subq	$0x430, %rsp            # imm = 0x430
               	leaq	-0x420(%rbp), %rax
               	movl	$0x64, %ecx
               	movl	%ecx, (%rax)
               	movl	$0xc8, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x12c, %ecx            # imm = 0x12C
               	movl	%ecx, 0x8(%rax)
               	movl	$0x190, %ecx            # imm = 0x190
               	movl	%ecx, 0xc(%rax)
               	movabsq	$-0x1, %rcx
               	movl	%ecx, 0xb0(%rax)
               	movabsq	$-0x2, %rcx
               	movl	%ecx, 0x154(%rax)
               	movabsq	$-0x3, %rcx
               	movl	%ecx, 0x1f8(%rax)
               	leaq	-0x420(%rbp), %rdx
               	movl	$0x1f4, %eax            # imm = 0x1F4
               	movl	%eax, 0x1fc(%rdx)
               	movl	$0x258, %eax            # imm = 0x258
               	movl	%eax, 0x200(%rdx)
               	movl	$0x2bc, %eax            # imm = 0x2BC
               	movl	%eax, 0x204(%rdx)
               	movl	$0x320, %eax            # imm = 0x320
               	movl	%eax, 0x208(%rdx)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x10(%rdx), %rdi
               	movslq	%ecx, %rax
               	leaq	0x3e8(%rax), %rsi
               	movl	%esi, (%rdi,%rax,4)
               	leaq	0xb4(%rdx), %rdi
               	leaq	0x7d0(%rax), %rsi
               	movl	%esi, (%rdi,%rax,4)
               	leaq	0x158(%rdx), %rdi
               	leaq	0xbb8(%rax), %rsi
               	movl	%esi, (%rdi,%rax,4)
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x28, %ecx
               	jl	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x7e, %esi
               	movl	$0x20c, %edx            # imm = 0x20C
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x210(%rbp), %rax
               	leaq	-0x420(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	movq	0x40(%rcx), %rdx
               	movq	%rdx, 0x40(%rax)
               	movq	0x48(%rcx), %rdx
               	movq	%rdx, 0x48(%rax)
               	movq	0x50(%rcx), %rdx
               	movq	%rdx, 0x50(%rax)
               	movq	0x58(%rcx), %rdx
               	movq	%rdx, 0x58(%rax)
               	movq	0x60(%rcx), %rdx
               	movq	%rdx, 0x60(%rax)
               	movq	0x68(%rcx), %rdx
               	movq	%rdx, 0x68(%rax)
               	movq	0x70(%rcx), %rdx
               	movq	%rdx, 0x70(%rax)
               	movq	0x78(%rcx), %rdx
               	movq	%rdx, 0x78(%rax)
               	movq	0x80(%rcx), %rdx
               	movq	%rdx, 0x80(%rax)
               	movq	0x88(%rcx), %rdx
               	movq	%rdx, 0x88(%rax)
               	movq	0x90(%rcx), %rdx
               	movq	%rdx, 0x90(%rax)
               	movq	0x98(%rcx), %rdx
               	movq	%rdx, 0x98(%rax)
               	movq	0xa0(%rcx), %rdx
               	movq	%rdx, 0xa0(%rax)
               	movq	0xa8(%rcx), %rdx
               	movq	%rdx, 0xa8(%rax)
               	movq	0xb0(%rcx), %rdx
               	movq	%rdx, 0xb0(%rax)
               	movq	0xb8(%rcx), %rdx
               	movq	%rdx, 0xb8(%rax)
               	movq	0xc0(%rcx), %rdx
               	movq	%rdx, 0xc0(%rax)
               	movq	0xc8(%rcx), %rdx
               	movq	%rdx, 0xc8(%rax)
               	movq	0xd0(%rcx), %rdx
               	movq	%rdx, 0xd0(%rax)
               	movq	0xd8(%rcx), %rdx
               	movq	%rdx, 0xd8(%rax)
               	movq	0xe0(%rcx), %rdx
               	movq	%rdx, 0xe0(%rax)
               	movq	0xe8(%rcx), %rdx
               	movq	%rdx, 0xe8(%rax)
               	movq	0xf0(%rcx), %rdx
               	movq	%rdx, 0xf0(%rax)
               	movq	0xf8(%rcx), %rdx
               	movq	%rdx, 0xf8(%rax)
               	movq	0x100(%rcx), %rdx
               	movq	%rdx, 0x100(%rax)
               	movq	0x108(%rcx), %rdx
               	movq	%rdx, 0x108(%rax)
               	movq	0x110(%rcx), %rdx
               	movq	%rdx, 0x110(%rax)
               	movq	0x118(%rcx), %rdx
               	movq	%rdx, 0x118(%rax)
               	movq	0x120(%rcx), %rdx
               	movq	%rdx, 0x120(%rax)
               	movq	0x128(%rcx), %rdx
               	movq	%rdx, 0x128(%rax)
               	movq	0x130(%rcx), %rdx
               	movq	%rdx, 0x130(%rax)
               	movq	0x138(%rcx), %rdx
               	movq	%rdx, 0x138(%rax)
               	movq	0x140(%rcx), %rdx
               	movq	%rdx, 0x140(%rax)
               	movq	0x148(%rcx), %rdx
               	movq	%rdx, 0x148(%rax)
               	movq	0x150(%rcx), %rdx
               	movq	%rdx, 0x150(%rax)
               	movq	0x158(%rcx), %rdx
               	movq	%rdx, 0x158(%rax)
               	movq	0x160(%rcx), %rdx
               	movq	%rdx, 0x160(%rax)
               	movq	0x168(%rcx), %rdx
               	movq	%rdx, 0x168(%rax)
               	movq	0x170(%rcx), %rdx
               	movq	%rdx, 0x170(%rax)
               	movq	0x178(%rcx), %rdx
               	movq	%rdx, 0x178(%rax)
               	movq	0x180(%rcx), %rdx
               	movq	%rdx, 0x180(%rax)
               	movq	0x188(%rcx), %rdx
               	movq	%rdx, 0x188(%rax)
               	movq	0x190(%rcx), %rdx
               	movq	%rdx, 0x190(%rax)
               	movq	0x198(%rcx), %rdx
               	movq	%rdx, 0x198(%rax)
               	movq	0x1a0(%rcx), %rdx
               	movq	%rdx, 0x1a0(%rax)
               	movq	0x1a8(%rcx), %rdx
               	movq	%rdx, 0x1a8(%rax)
               	movq	0x1b0(%rcx), %rdx
               	movq	%rdx, 0x1b0(%rax)
               	movq	0x1b8(%rcx), %rdx
               	movq	%rdx, 0x1b8(%rax)
               	movq	0x1c0(%rcx), %rdx
               	movq	%rdx, 0x1c0(%rax)
               	movq	0x1c8(%rcx), %rdx
               	movq	%rdx, 0x1c8(%rax)
               	movq	0x1d0(%rcx), %rdx
               	movq	%rdx, 0x1d0(%rax)
               	movq	0x1d8(%rcx), %rdx
               	movq	%rdx, 0x1d8(%rax)
               	movq	0x1e0(%rcx), %rdx
               	movq	%rdx, 0x1e0(%rax)
               	movq	0x1e8(%rcx), %rdx
               	movq	%rdx, 0x1e8(%rax)
               	movq	0x1f0(%rcx), %rdx
               	movq	%rdx, 0x1f0(%rax)
               	movq	0x1f8(%rcx), %rdx
               	movq	%rdx, 0x1f8(%rax)
               	movq	0x200(%rcx), %rdx
               	movq	%rdx, 0x200(%rax)
               	movzbq	0x208(%rcx), %rdx
               	movb	%dl, 0x208(%rax)
               	movzbq	0x209(%rcx), %rdx
               	movb	%dl, 0x209(%rax)
               	movzbq	0x20a(%rcx), %rdx
               	movb	%dl, 0x20a(%rax)
               	movzbq	0x20b(%rcx), %rdx
               	movb	%dl, 0x20b(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movslq	(%rax), %rcx
               	cmpl	$0x64, %ecx
               	movl	$0x1, %edx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0xc8, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x12c, %ecx            # imm = 0x12C
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x190, %ecx            # imm = 0x190
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	movslq	0x1fc(%rax), %rax
               	cmpl	$0x1f4, %eax            # imm = 0x1F4
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x210(%rbp), %rcx
               	movslq	0x200(%rcx), %rcx
               	cmpl	$0x258, %ecx            # imm = 0x258
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x210(%rbp), %rax
               	movslq	0x204(%rax), %rax
               	cmpl	$0x2bc, %eax            # imm = 0x2BC
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x210(%rbp), %rax
               	movslq	0x208(%rax), %rax
               	cmpl	$0x320, %eax            # imm = 0x320
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x210(%rbp), %rdx
               	movslq	0xb0(%rdx), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movslq	0x154(%rdx), %rax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movslq	0x1f8(%rdx), %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x10(%rdx), %rsi
               	movslq	%ecx, %rax
               	movslq	(%rsi,%rax,4), %rdi
               	leaq	0x3e8(%rax), %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	leaq	0xb4(%rdx), %rsi
               	movslq	(%rsi,%rax,4), %rdi
               	leaq	0x7d0(%rax), %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	leaq	0x158(%rdx), %rsi
               	movslq	(%rsi,%rax,4), %rdi
               	leaq	0xbb8(%rax), %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x28, %ecx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
               	leaq	0x6e(%rcx), %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	0x3c(%rcx), %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	0xa(%rcx), %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
