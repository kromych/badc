
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
               	movq	$-0x1, %rax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rax, -0x8(%rbp)
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rax, -0x8(%rbp)
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	$-0x2, %rax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	$-0x1, %rcx
               	movq	%rcx, -0x8(%rbp)
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x6, %rax
               	je	<addr>
               	leave
               	retq
               	movq	%rcx, -0x8(%rbp)
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x8(%rbp)
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	%rcx, -0x8(%rbp)
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	%rax, -0x8(%rbp)
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	$-0x2, %rax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	movq	%rax, -0x8(%rbp)
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movq	$-0x8, %rax
               	movq	%rax, -0x8(%rbp)
               	cmpq	$-0x8, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movabsq	$0x7ffffffffffffffe, %rcx # imm = 0x7FFFFFFFFFFFFFFE
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movabsq	$0x7ffffffffffffffe, %r11 # imm = 0x7FFFFFFFFFFFFFFE
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movq	%rax, -0x8(%rbp)
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movq	$0x0, -0x8(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	movq	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x8(%rbp), %ecx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x2a, %eax
               	leave
               	retq
               	movl	$0xffffffff, -0x8(%rbp) # imm = 0xFFFFFFFF
               	movl	-0x8(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x2b, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	movl	%eax, -0x8(%rbp)
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2c, %eax
               	leave
               	retq
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	movl	%eax, -0x8(%rbp)
               	cmpl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x2d, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
