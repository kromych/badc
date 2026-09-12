
zero_literal_assign.x64:	file format elf64-x86-64

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

<zero_pointer>:
               	movq	$0x0, (%rdi)
               	movq	$0x0, 0x8(%rdi)
               	xorq	%rax, %rax
               	retq

<zero_designated>:
               	movq	$0x0, (%rdi)
               	movq	$0x0, 0x8(%rdi)
               	xorq	%rax, %rax
               	retq

<zero_bytes>:
               	movw	$0x0, (%rdi)
               	movb	$0x0, 0x2(%rdi)
               	xorq	%rax, %rax
               	retq

<zero_mixed>:
               	movq	$0x0, (%rdi)
               	xorq	%rax, %rax
               	retq

<zero_tail>:
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	movb	$0x0, 0xc(%rdi)
               	xorq	%rax, %rax
               	retq

<zero_union>:
               	movq	$0x0, (%rdi)
               	movq	$0x0, 0x8(%rdi)
               	xorq	%rax, %rax
               	retq

<zero_chained>:
               	movq	$0x0, (%rdi)
               	movq	$0x0, 0x8(%rdi)
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	xorq	%rax, %rax
               	retq

<zero_above_bound>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x260, %rsp            # imm = 0x260
               	leaq	-0x258(%rbp), %rax
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
               	movq	0x200(%rcx), %rdx
               	movq	%rdx, 0x200(%rax)
               	movq	0x208(%rcx), %rdx
               	movq	%rdx, 0x208(%rax)
               	movq	0x210(%rcx), %rdx
               	movq	%rdx, 0x210(%rax)
               	movq	0x218(%rcx), %rdx
               	movq	%rdx, 0x218(%rax)
               	movq	0x220(%rcx), %rdx
               	movq	%rdx, 0x220(%rax)
               	movq	0x228(%rcx), %rdx
               	movq	%rdx, 0x228(%rax)
               	movq	0x230(%rcx), %rdx
               	movq	%rdx, 0x230(%rax)
               	movq	0x238(%rcx), %rdx
               	movq	%rdx, 0x238(%rax)
               	movq	0x240(%rcx), %rdx
               	movq	%rdx, 0x240(%rax)
               	movq	0x248(%rcx), %rdx
               	movq	%rdx, 0x248(%rax)
               	movq	0x250(%rcx), %rdx
               	movq	%rdx, 0x250(%rax)
               	popq	%rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rdi)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rdi)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%rdi)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%rdi)
               	movq	0x40(%rax), %rcx
               	movq	%rcx, 0x40(%rdi)
               	movq	0x48(%rax), %rcx
               	movq	%rcx, 0x48(%rdi)
               	movq	0x50(%rax), %rcx
               	movq	%rcx, 0x50(%rdi)
               	movq	0x58(%rax), %rcx
               	movq	%rcx, 0x58(%rdi)
               	movq	0x60(%rax), %rcx
               	movq	%rcx, 0x60(%rdi)
               	movq	0x68(%rax), %rcx
               	movq	%rcx, 0x68(%rdi)
               	movq	0x70(%rax), %rcx
               	movq	%rcx, 0x70(%rdi)
               	movq	0x78(%rax), %rcx
               	movq	%rcx, 0x78(%rdi)
               	movq	0x80(%rax), %rcx
               	movq	%rcx, 0x80(%rdi)
               	movq	0x88(%rax), %rcx
               	movq	%rcx, 0x88(%rdi)
               	movq	0x90(%rax), %rcx
               	movq	%rcx, 0x90(%rdi)
               	movq	0x98(%rax), %rcx
               	movq	%rcx, 0x98(%rdi)
               	movq	0xa0(%rax), %rcx
               	movq	%rcx, 0xa0(%rdi)
               	movq	0xa8(%rax), %rcx
               	movq	%rcx, 0xa8(%rdi)
               	movq	0xb0(%rax), %rcx
               	movq	%rcx, 0xb0(%rdi)
               	movq	0xb8(%rax), %rcx
               	movq	%rcx, 0xb8(%rdi)
               	movq	0xc0(%rax), %rcx
               	movq	%rcx, 0xc0(%rdi)
               	movq	0xc8(%rax), %rcx
               	movq	%rcx, 0xc8(%rdi)
               	movq	0xd0(%rax), %rcx
               	movq	%rcx, 0xd0(%rdi)
               	movq	0xd8(%rax), %rcx
               	movq	%rcx, 0xd8(%rdi)
               	movq	0xe0(%rax), %rcx
               	movq	%rcx, 0xe0(%rdi)
               	movq	0xe8(%rax), %rcx
               	movq	%rcx, 0xe8(%rdi)
               	movq	0xf0(%rax), %rcx
               	movq	%rcx, 0xf0(%rdi)
               	movq	0xf8(%rax), %rcx
               	movq	%rcx, 0xf8(%rdi)
               	movq	0x100(%rax), %rcx
               	movq	%rcx, 0x100(%rdi)
               	movq	0x108(%rax), %rcx
               	movq	%rcx, 0x108(%rdi)
               	movq	0x110(%rax), %rcx
               	movq	%rcx, 0x110(%rdi)
               	movq	0x118(%rax), %rcx
               	movq	%rcx, 0x118(%rdi)
               	movq	0x120(%rax), %rcx
               	movq	%rcx, 0x120(%rdi)
               	movq	0x128(%rax), %rcx
               	movq	%rcx, 0x128(%rdi)
               	movq	0x130(%rax), %rcx
               	movq	%rcx, 0x130(%rdi)
               	movq	0x138(%rax), %rcx
               	movq	%rcx, 0x138(%rdi)
               	movq	0x140(%rax), %rcx
               	movq	%rcx, 0x140(%rdi)
               	movq	0x148(%rax), %rcx
               	movq	%rcx, 0x148(%rdi)
               	movq	0x150(%rax), %rcx
               	movq	%rcx, 0x150(%rdi)
               	movq	0x158(%rax), %rcx
               	movq	%rcx, 0x158(%rdi)
               	movq	0x160(%rax), %rcx
               	movq	%rcx, 0x160(%rdi)
               	movq	0x168(%rax), %rcx
               	movq	%rcx, 0x168(%rdi)
               	movq	0x170(%rax), %rcx
               	movq	%rcx, 0x170(%rdi)
               	movq	0x178(%rax), %rcx
               	movq	%rcx, 0x178(%rdi)
               	movq	0x180(%rax), %rcx
               	movq	%rcx, 0x180(%rdi)
               	movq	0x188(%rax), %rcx
               	movq	%rcx, 0x188(%rdi)
               	movq	0x190(%rax), %rcx
               	movq	%rcx, 0x190(%rdi)
               	movq	0x198(%rax), %rcx
               	movq	%rcx, 0x198(%rdi)
               	movq	0x1a0(%rax), %rcx
               	movq	%rcx, 0x1a0(%rdi)
               	movq	0x1a8(%rax), %rcx
               	movq	%rcx, 0x1a8(%rdi)
               	movq	0x1b0(%rax), %rcx
               	movq	%rcx, 0x1b0(%rdi)
               	movq	0x1b8(%rax), %rcx
               	movq	%rcx, 0x1b8(%rdi)
               	movq	0x1c0(%rax), %rcx
               	movq	%rcx, 0x1c0(%rdi)
               	movq	0x1c8(%rax), %rcx
               	movq	%rcx, 0x1c8(%rdi)
               	movq	0x1d0(%rax), %rcx
               	movq	%rcx, 0x1d0(%rdi)
               	movq	0x1d8(%rax), %rcx
               	movq	%rcx, 0x1d8(%rdi)
               	movq	0x1e0(%rax), %rcx
               	movq	%rcx, 0x1e0(%rdi)
               	movq	0x1e8(%rax), %rcx
               	movq	%rcx, 0x1e8(%rdi)
               	movq	0x1f0(%rax), %rcx
               	movq	%rcx, 0x1f0(%rdi)
               	movq	0x1f8(%rax), %rcx
               	movq	%rcx, 0x1f8(%rdi)
               	movq	0x200(%rax), %rcx
               	movq	%rcx, 0x200(%rdi)
               	movq	0x208(%rax), %rcx
               	movq	%rcx, 0x208(%rdi)
               	movq	0x210(%rax), %rcx
               	movq	%rcx, 0x210(%rdi)
               	movq	0x218(%rax), %rcx
               	movq	%rcx, 0x218(%rdi)
               	movq	0x220(%rax), %rcx
               	movq	%rcx, 0x220(%rdi)
               	movq	0x228(%rax), %rcx
               	movq	%rcx, 0x228(%rdi)
               	movq	0x230(%rax), %rcx
               	movq	%rcx, 0x230(%rdi)
               	movq	0x238(%rax), %rcx
               	movq	%rcx, 0x238(%rdi)
               	movq	0x240(%rax), %rcx
               	movq	%rcx, 0x240(%rdi)
               	movq	0x248(%rax), %rcx
               	movq	%rcx, 0x248(%rdi)
               	movq	0x250(%rax), %rcx
               	movq	%rcx, 0x250(%rdi)
               	popq	%rcx
               	xorq	%rax, %rax
               	leave
               	retq

<copy_nonzero>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	xorq	%rax, %rax
               	leave
               	retq

<zero_local>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movq	$0x0, (%rax)
               	xorq	%rax, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x260, %rsp            # imm = 0x260
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	leave
               	retq
