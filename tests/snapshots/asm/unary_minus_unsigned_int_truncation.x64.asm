
unary_minus_unsigned_int_truncation.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0x1, %r11d
               	movabsq	$-0x1, %r9
               	imulq	%r11, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	cmpq	%r10, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r9
               	imulq	%r11, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	orq	%r11, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	cmpq	%r10, %r9
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r9
               	imulq	%r11, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	orq	%r11, %r9
               	shrq	$0x1f, %r9
               	cmpq	$0x1, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movabsq	$-0x1, %rax
               	imulq	%r9, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	orq	%rax, %r9
               	shrq	$0x1f, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r9
               	imulq	%r11, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	orq	%r11, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	orq	%r9, %r11
               	shrq	$0x1f, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r11d
               	xorq	%rax, %rax
               	xorq	%rax, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movabsq	$-0x1, %rax
               	imulq	%r11, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	orq	%rax, %r11
               	shrq	$0x1f, %r11
               	xorq	$0x1, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %r11d
               	xorq	%r11, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movabsq	$-0x1, %rax
               	imulq	%r11, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	orq	%rax, %r11
               	shrq	$0x1f, %r11
               	xorq	$0x1, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
