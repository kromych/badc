
enum_unsigned_value_cmp.x64:	file format elf64-x86-64

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
               	movl	$0x80000000, -0x10(%rbp) # imm = 0x80000000
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	movslq	-0x10(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	xorq	%r11, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	xorq	%r11, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpl	%r11d, %eax
               	jae	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpl	%r11d, %eax
               	ja	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpl	%r11d, %eax
               	jae	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpl	%r11d, %eax
               	jbe	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	addq	%r11, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
