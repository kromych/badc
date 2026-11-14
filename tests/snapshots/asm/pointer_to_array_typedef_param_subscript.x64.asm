
pointer_to_array_typedef_param_subscript.x64:	file format elf64-x86-64

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
               	subq	$0x100, %rsp            # imm = 0x100
               	movl	$0x1, %eax
               	movq	%rax, -0xf8(%rbp)
               	movq	$0x2, -0xf0(%rbp)
               	movq	$0x3, -0xe8(%rbp)
               	movq	$0x4, -0xe0(%rbp)
               	movq	$0x5, -0xd8(%rbp)
               	movq	$0x6, -0xd0(%rbp)
               	movq	$0x7, -0xc8(%rbp)
               	movq	$0xc8, -0x80(%rbp)
               	movq	$0xc9, -0x78(%rbp)
               	movq	$0xca, -0x70(%rbp)
               	movq	$0xcb, -0x68(%rbp)
               	movq	$0xcc, -0x60(%rbp)
               	movq	$0xcd, -0x58(%rbp)
               	movq	$0xce, -0x50(%rbp)
               	movq	$0xcf, -0x48(%rbp)
               	movq	$0x12c, -0x40(%rbp)     # imm = 0x12C
               	movq	$0x12d, -0x38(%rbp)     # imm = 0x12D
               	movq	$0x12e, -0x30(%rbp)     # imm = 0x12E
               	movq	$0x12f, -0x28(%rbp)     # imm = 0x12F
               	movq	$0x130, -0x20(%rbp)     # imm = 0x130
               	movq	$0x131, -0x18(%rbp)     # imm = 0x131
               	movq	$0x132, -0x10(%rbp)     # imm = 0x132
               	movq	$0x133, -0x8(%rbp)      # imm = 0x133
               	movq	-0xf8(%rbp), %rcx
               	movq	-0xf0(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	-0xe8(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	-0xe0(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	-0xd8(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	-0xd0(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	-0xc8(%rbp), %rdx
               	addq	%rdx, %rcx
               	cmpq	$0x1c, %rcx
               	je	<addr>
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x70(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x68(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x60(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x58(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x50(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x48(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x65c, %rax            # imm = 0x65C
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x97c, %rax            # imm = 0x97C
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x40(%rbp), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
