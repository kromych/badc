
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
               	subq	$0x440, %rsp            # imm = 0x440
               	movq	%rbx, (%rsp)
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
               	leaq	0x3e8(%rax), %rsi
               	movl	%esi, (%rdi,%rax,4)
               	leaq	0xb4(%rdx), %rdi
               	leaq	0x7d0(%rax), %rsi
               	movl	%esi, (%rdi,%rax,4)
               	leaq	0x158(%rdx), %rdi
               	leaq	0xbb8(%rax), %rsi
               	movl	%esi, (%rdi,%rax,4)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x28, %rax
               	jl	<addr>
               	leaq	-0x210(%rbp), %rbx
               	movl	$0x7e, %esi
               	movl	$0x20c, %edx            # imm = 0x20C
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x420(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rbx)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rbx)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rbx)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rbx)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%rbx)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%rbx)
               	movq	0x40(%rax), %rcx
               	movq	%rcx, 0x40(%rbx)
               	movq	0x48(%rax), %rcx
               	movq	%rcx, 0x48(%rbx)
               	movq	0x50(%rax), %rcx
               	movq	%rcx, 0x50(%rbx)
               	movq	0x58(%rax), %rcx
               	movq	%rcx, 0x58(%rbx)
               	movq	0x60(%rax), %rcx
               	movq	%rcx, 0x60(%rbx)
               	movq	0x68(%rax), %rcx
               	movq	%rcx, 0x68(%rbx)
               	movq	0x70(%rax), %rcx
               	movq	%rcx, 0x70(%rbx)
               	movq	0x78(%rax), %rcx
               	movq	%rcx, 0x78(%rbx)
               	movq	0x80(%rax), %rcx
               	movq	%rcx, 0x80(%rbx)
               	movq	0x88(%rax), %rcx
               	movq	%rcx, 0x88(%rbx)
               	movq	0x90(%rax), %rcx
               	movq	%rcx, 0x90(%rbx)
               	movq	0x98(%rax), %rcx
               	movq	%rcx, 0x98(%rbx)
               	movq	0xa0(%rax), %rcx
               	movq	%rcx, 0xa0(%rbx)
               	movq	0xa8(%rax), %rcx
               	movq	%rcx, 0xa8(%rbx)
               	movq	0xb0(%rax), %rcx
               	movq	%rcx, 0xb0(%rbx)
               	movq	0xb8(%rax), %rcx
               	movq	%rcx, 0xb8(%rbx)
               	movq	0xc0(%rax), %rcx
               	movq	%rcx, 0xc0(%rbx)
               	movq	0xc8(%rax), %rcx
               	movq	%rcx, 0xc8(%rbx)
               	movq	0xd0(%rax), %rcx
               	movq	%rcx, 0xd0(%rbx)
               	movq	0xd8(%rax), %rcx
               	movq	%rcx, 0xd8(%rbx)
               	movq	0xe0(%rax), %rcx
               	movq	%rcx, 0xe0(%rbx)
               	movq	0xe8(%rax), %rcx
               	movq	%rcx, 0xe8(%rbx)
               	movq	0xf0(%rax), %rcx
               	movq	%rcx, 0xf0(%rbx)
               	movq	0xf8(%rax), %rcx
               	movq	%rcx, 0xf8(%rbx)
               	movq	0x100(%rax), %rcx
               	movq	%rcx, 0x100(%rbx)
               	movq	0x108(%rax), %rcx
               	movq	%rcx, 0x108(%rbx)
               	movq	0x110(%rax), %rcx
               	movq	%rcx, 0x110(%rbx)
               	movq	0x118(%rax), %rcx
               	movq	%rcx, 0x118(%rbx)
               	movq	0x120(%rax), %rcx
               	movq	%rcx, 0x120(%rbx)
               	movq	0x128(%rax), %rcx
               	movq	%rcx, 0x128(%rbx)
               	movq	0x130(%rax), %rcx
               	movq	%rcx, 0x130(%rbx)
               	movq	0x138(%rax), %rcx
               	movq	%rcx, 0x138(%rbx)
               	movq	0x140(%rax), %rcx
               	movq	%rcx, 0x140(%rbx)
               	movq	0x148(%rax), %rcx
               	movq	%rcx, 0x148(%rbx)
               	movq	0x150(%rax), %rcx
               	movq	%rcx, 0x150(%rbx)
               	movq	0x158(%rax), %rcx
               	movq	%rcx, 0x158(%rbx)
               	movq	0x160(%rax), %rcx
               	movq	%rcx, 0x160(%rbx)
               	movq	0x168(%rax), %rcx
               	movq	%rcx, 0x168(%rbx)
               	movq	0x170(%rax), %rcx
               	movq	%rcx, 0x170(%rbx)
               	movq	0x178(%rax), %rcx
               	movq	%rcx, 0x178(%rbx)
               	movq	0x180(%rax), %rcx
               	movq	%rcx, 0x180(%rbx)
               	movq	0x188(%rax), %rcx
               	movq	%rcx, 0x188(%rbx)
               	movq	0x190(%rax), %rcx
               	movq	%rcx, 0x190(%rbx)
               	movq	0x198(%rax), %rcx
               	movq	%rcx, 0x198(%rbx)
               	movq	0x1a0(%rax), %rcx
               	movq	%rcx, 0x1a0(%rbx)
               	movq	0x1a8(%rax), %rcx
               	movq	%rcx, 0x1a8(%rbx)
               	movq	0x1b0(%rax), %rcx
               	movq	%rcx, 0x1b0(%rbx)
               	movq	0x1b8(%rax), %rcx
               	movq	%rcx, 0x1b8(%rbx)
               	movq	0x1c0(%rax), %rcx
               	movq	%rcx, 0x1c0(%rbx)
               	movq	0x1c8(%rax), %rcx
               	movq	%rcx, 0x1c8(%rbx)
               	movq	0x1d0(%rax), %rcx
               	movq	%rcx, 0x1d0(%rbx)
               	movq	0x1d8(%rax), %rcx
               	movq	%rcx, 0x1d8(%rbx)
               	movq	0x1e0(%rax), %rcx
               	movq	%rcx, 0x1e0(%rbx)
               	movq	0x1e8(%rax), %rcx
               	movq	%rcx, 0x1e8(%rbx)
               	movq	0x1f0(%rax), %rcx
               	movq	%rcx, 0x1f0(%rbx)
               	movq	0x1f8(%rax), %rcx
               	movq	%rcx, 0x1f8(%rbx)
               	movq	0x200(%rax), %rcx
               	movq	%rcx, 0x200(%rbx)
               	movzbq	0x208(%rax), %rcx
               	movb	%cl, 0x208(%rbx)
               	movzbq	0x209(%rax), %rcx
               	movb	%cl, 0x209(%rbx)
               	movzbq	0x20a(%rax), %rcx
               	movb	%cl, 0x20a(%rbx)
               	movzbq	0x20b(%rax), %rcx
               	movb	%cl, 0x20b(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x210(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x64, %rcx
               	movl	$0x1, %edx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpq	$0xc8, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpq	$0x12c, %rcx            # imm = 0x12C
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpq	$0x190, %rcx            # imm = 0x190
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	%rdx, %rax
               	addq	$0x440, %rsp            # imm = 0x440
               	popq	%rbp
               	retq
               	movslq	0x1fc(%rax), %rax
               	cmpq	$0x1f4, %rax            # imm = 0x1F4
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x210(%rbp), %rcx
               	movslq	0x200(%rcx), %rcx
               	cmpq	$0x258, %rcx            # imm = 0x258
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x210(%rbp), %rax
               	movslq	0x204(%rax), %rax
               	cmpq	$0x2bc, %rax            # imm = 0x2BC
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x210(%rbp), %rax
               	movslq	0x208(%rax), %rax
               	cmpq	$0x320, %rax            # imm = 0x320
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x440, %rsp            # imm = 0x440
               	popq	%rbp
               	retq
               	leaq	-0x210(%rbp), %rdx
               	movslq	0xb0(%rdx), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x440, %rsp            # imm = 0x440
               	popq	%rbp
               	retq
               	movslq	0x154(%rdx), %rax
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x440, %rsp            # imm = 0x440
               	popq	%rbp
               	retq
               	movslq	0x1f8(%rdx), %rax
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x440, %rsp            # imm = 0x440
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x10(%rdx), %rsi
               	movslq	(%rsi,%rax,4), %rdi
               	leaq	0x3e8(%rax), %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	leaq	0xb4(%rdx), %rsi
               	movslq	(%rsi,%rax,4), %rdi
               	leaq	0x7d0(%rax), %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	leaq	0x158(%rdx), %rsi
               	movslq	(%rsi,%rax,4), %rdi
               	leaq	0xbb8(%rax), %rsi
               	movslq	%esi, %rsi
               	cmpq	%rsi, %rdi
               	jne	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x28, %rax
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x440, %rsp            # imm = 0x440
               	popq	%rbp
               	retq
               	leaq	0x6e(%rcx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x440, %rsp            # imm = 0x440
               	popq	%rbp
               	retq
               	leaq	0x3c(%rcx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x440, %rsp            # imm = 0x440
               	popq	%rbp
               	retq
               	leaq	0xa(%rcx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x440, %rsp            # imm = 0x440
               	popq	%rbp
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
