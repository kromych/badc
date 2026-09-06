
auto_struct_array_multi_dim.x64:	file format elf64-x86-64

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

<runtime3d>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	leaq	-0x120(%rbp), %rax
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
               	popq	%rdx
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	$0x1020, %edx           # imm = 0x1020
               	movq	%rdx, 0x10(%rax)
               	movl	$0x1001, %edx           # imm = 0x1001
               	movq	%rdx, 0x18(%rax)
               	movl	$0x1040, %edx           # imm = 0x1040
               	movq	%rdx, 0x20(%rax)
               	movl	$0x1002, %edx           # imm = 0x1002
               	movq	%rdx, 0x28(%rax)
               	leaq	-0x120(%rbp), %rax
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	movl	$0x1003, %edx           # imm = 0x1003
               	movq	%rdx, 0x40(%rax)
               	movl	$0x9060, %edx           # imm = 0x9060
               	movq	%rdx, 0x48(%rax)
               	movl	$0x1004, %edx           # imm = 0x1004
               	movq	%rdx, 0x50(%rax)
               	movl	$0x9005, %edx           # imm = 0x9005
               	movq	%rdx, 0x58(%rax)
               	movl	$0x9006, %edx           # imm = 0x9006
               	movq	%rdx, 0x60(%rax)
               	leaq	-0x120(%rbp), %rax
               	movq	%rcx, 0x68(%rax)
               	movl	$0x9007, %edx           # imm = 0x9007
               	movq	%rdx, 0x70(%rax)
               	movq	%rcx, 0x78(%rax)
               	movl	$0x9008, %edx           # imm = 0x9008
               	movq	%rdx, 0x80(%rax)
               	movq	%rcx, 0x88(%rax)
               	movq	%rcx, 0x90(%rax)
               	movl	$0x9009, %edx           # imm = 0x9009
               	leaq	-0x120(%rbp), %rax
               	movq	%rdx, 0x98(%rax)
               	movq	%rcx, 0xa0(%rax)
               	movl	$0x100a, %edx           # imm = 0x100A
               	movq	%rdx, 0xa8(%rax)
               	movq	%rcx, 0xb0(%rax)
               	movl	$0x100b, %ecx           # imm = 0x100B
               	movq	%rcx, 0xb8(%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x2, %edi
               	movl	$0x1000, %esi           # imm = 0x1000
               	movl	$0x9000, %edx           # imm = 0x9000
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
