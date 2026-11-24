
enum_unsigned_value_cmp.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movl	$0x80000000, (%rsp)     # imm = 0x80000000
               	movl	$0xffffffff, 0x8(%rsp)  # imm = 0xFFFFFFFF
               	movl	(%rsp), %eax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	(%rsp), %eax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	jae	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	0x8(%rsp), %eax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	ja	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	(%rsp), %eax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	jae	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	(%rsp), %eax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	jbe	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	(%rsp), %eax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	addq	%r11, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	(%rsp), %eax
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
