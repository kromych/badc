
struct_stack_arg_then_scalar.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	imulq	$0xf4240, %rax, %rax    # imm = 0xF4240
               	movslq	%eax, %rax
               	addq	$0x30d40, %rax          # imm = 0x30D40
               	addq	$0x1b58, %rax           # imm = 0x1B58
               	addq	$0xfa0, %rax            # imm = 0xFA0
               	addq	$0x1e, %rax
               	addq	$0x3, %rax
               	addq	$0x5, %rax
               	cmpq	$0x127a9e, %rax         # imm = 0x127A9E
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
