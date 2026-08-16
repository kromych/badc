
zero_local_aggregate_no_template.x64:	file format elf64-x86-64

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

<seven>:
               	movl	$0x7, %eax
               	retq

<label_template>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movslq	%edi, %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movl	$0xa, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movl	$0x14, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x230, %rsp            # imm = 0x230
               	movq	%rbx, (%rsp)
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %eax
               	leaq	-0x28(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movl	%ecx, 0x8(%rax)
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x9, %edx
               	leaq	-0x28(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movl	%edx, (%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0xc(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x218(%rbp), %rax
               	leaq	<rip>, %rcx
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
               	popq	%rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x218(%rbp), %rdx
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x200, %rcx            # imm = 0x200
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rbx, %rbx
               	leaq	-<rip>, %rax      # <addr>
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x230, %rsp            # imm = 0x230
               	popq	%rbp
               	retq
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
