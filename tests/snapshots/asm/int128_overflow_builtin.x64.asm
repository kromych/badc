
int128_overflow_builtin.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movl	$0x7b, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x7b, %eax
               	je	<addr>
               	movl	$0x38, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	$0x0, -0x8(%rbp)
               	movl	$0xfffffffe, -0x8(%rbp) # imm = 0xFFFFFFFE
               	movl	$0x0, -0x8(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	$-0xf, -0x8(%rbp)
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x8(%rbp)
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
