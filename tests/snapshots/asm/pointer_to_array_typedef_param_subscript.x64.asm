
pointer_to_array_typedef_param_subscript.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x108, %rsp            # imm = 0x108
               	movl	$0x1, %eax
               	movq	%rax, 0x8(%rsp)
               	movl	$0x2, %ecx
               	movq	%rcx, 0x10(%rsp)
               	movq	$0x3, 0x18(%rsp)
               	movq	$0x4, 0x20(%rsp)
               	movq	$0x5, 0x28(%rsp)
               	movq	$0x6, 0x30(%rsp)
               	movq	$0x7, 0x38(%rsp)
               	movq	$0xc8, 0x80(%rsp)
               	movq	$0xc9, 0x88(%rsp)
               	movq	$0xca, 0x90(%rsp)
               	movq	$0xcb, 0x98(%rsp)
               	movq	$0xcc, 0xa0(%rsp)
               	movq	$0xcd, 0xa8(%rsp)
               	movq	$0xce, 0xb0(%rsp)
               	movq	$0xcf, 0xb8(%rsp)
               	movq	$0x12c, 0xc0(%rsp)      # imm = 0x12C
               	movq	$0x12d, 0xc8(%rsp)      # imm = 0x12D
               	movq	$0x12e, 0xd0(%rsp)      # imm = 0x12E
               	movq	$0x12f, 0xd8(%rsp)      # imm = 0x12F
               	movq	$0x130, 0xe0(%rsp)      # imm = 0x130
               	movq	$0x131, 0xe8(%rsp)      # imm = 0x131
               	movq	$0x132, 0xf0(%rsp)      # imm = 0x132
               	movq	$0x133, 0xf8(%rsp)      # imm = 0x133
               	movq	0x8(%rsp), %rdx
               	movq	0x10(%rsp), %rsi
               	addq	%rsi, %rdx
               	movq	0x18(%rsp), %rsi
               	addq	%rsi, %rdx
               	movq	0x20(%rsp), %rsi
               	addq	%rsi, %rdx
               	movq	0x28(%rsp), %rsi
               	addq	%rsi, %rdx
               	movq	0x30(%rsp), %rsi
               	addq	%rsi, %rdx
               	movq	0x38(%rsp), %rsi
               	addq	%rsi, %rdx
               	cmpq	$0x1c, %rdx
               	je	<addr>
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rdx
               	addq	%rdx, %rax
               	movq	0x90(%rsp), %rdx
               	addq	%rdx, %rax
               	movq	0x98(%rsp), %rdx
               	addq	%rdx, %rax
               	movq	0xa0(%rsp), %rdx
               	addq	%rdx, %rax
               	movq	0xa8(%rsp), %rdx
               	addq	%rdx, %rax
               	movq	0xb0(%rsp), %rdx
               	addq	%rdx, %rax
               	movq	0xb8(%rsp), %rdx
               	addq	%rdx, %rax
               	cmpq	$0x65c, %rax            # imm = 0x65C
               	je	<addr>
               	movq	%rcx, %rax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	movq	0xc0(%rsp), %rax
               	movq	0xc8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xd0(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xd8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xe0(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xe8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xf0(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0xf8(%rsp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x97c, %rax            # imm = 0x97C
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	movq	0xc0(%rsp), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	xorl	%eax, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
