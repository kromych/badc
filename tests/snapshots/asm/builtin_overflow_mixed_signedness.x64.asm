
builtin_overflow_mixed_signedness.x64:	file format elf64-x86-64

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
               	movq	$-0x1, -0x8(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	$-0x2, -0x8(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	$0x6, -0x8(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, -0x8(%rbp)
               	movq	$-0x1, -0x8(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, -0x8(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	$-0x2, -0x8(%rbp)
               	movq	$-0x2, -0x8(%rbp)
               	movq	$0x8, -0x8(%rbp)
               	movq	$-0x8, -0x8(%rbp)
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movabsq	$0x7ffffffffffffffe, %rax # imm = 0x7FFFFFFFFFFFFFFE
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x7ffffffffffffffe, %r11 # imm = 0x7FFFFFFFFFFFFFFE
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movq	%rcx, -0x8(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, -0x8(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x8(%rbp), %ecx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x8(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x2b, %eax
               	leave
               	retq
               	movl	$0x5, -0x8(%rbp)
               	movl	$0x7fffffff, -0x8(%rbp) # imm = 0x7FFFFFFF
               	xorl	%eax, %eax
               	leave
               	retq
