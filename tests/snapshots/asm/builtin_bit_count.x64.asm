
builtin_bit_count.x64:	file format elf64-x86-64

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
               	movl	$0xff00ff, -0x10(%rbp)  # imm = 0xFF00FF
               	movl	-0x10(%rbp), %ecx
               	popcntl	%ecx, %ecx
               	cmpl	$0x10, %ecx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movl	-0x10(%rbp), %ecx
               	movl	$0x3f, %r11d
               	bsrl	%ecx, %ecx
               	cmovel	%r11d, %ecx
               	xorl	$0x1f, %ecx
               	cmpl	$0x8, %ecx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movl	-0x10(%rbp), %ecx
               	movl	$0x20, %r11d
               	bsfl	%ecx, %ecx
               	cmovel	%r11d, %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movq	$0xff00ff, -0x8(%rbp)   # imm = 0xFF00FF
               	movq	-0x8(%rbp), %rax
               	popcntq	%rax, %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movl	$0x40, %r11d
               	bsfq	%rax, %rax
               	cmovel	%r11d, %eax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
