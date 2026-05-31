
unary_minus_unsigned_int_truncation.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0x1, %r11d
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movabsq	$-0x1, %r10
               	imulq	%r10, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	cmpq	%r10, %r9
               	je	0x400272 <.text+0x52>
               	movl	$0x1, %eax
               	retq
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movabsq	$-0x1, %rax
               	imulq	%r9, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	orq	%rax, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	cmpq	%r10, %r9
               	je	0x4002aa <.text+0x8a>
               	movl	$0x2, %eax
               	retq
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movabsq	$-0x1, %rax
               	imulq	%r9, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	orq	%rax, %r9
               	shrq	$0x1f, %r9
               	cmpq	$0x1, %r9
               	je	0x4002e4 <.text+0xc4>
               	movl	$0x3, %eax
               	retq
               	xorq	%r9, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r9
               	movabsq	$-0x1, %rax
               	imulq	%r9, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	orq	%rax, %r9
               	shrq	$0x1f, %r9
               	cmpq	$0x0, %r9
               	je	0x400321 <.text+0x101>
               	movl	$0x4, %eax
               	retq
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movabsq	$-0x1, %rax
               	imulq	%r9, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rax, %rdi
               	orq	%rdi, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	cmpq	%r10, %r9
               	je	0x400364 <.text+0x144>
               	movl	$0x5, %edi
               	movq	%rdi, %rax
               	retq
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
               	orq	%rax, %r11
               	shrq	$0x1f, %r11
               	cmpq	$0x1, %r11
               	je	0x400390 <.text+0x170>
               	movl	$0x6, %eax
               	retq
               	movl	$0x1, %r11d
               	xorq	%rax, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %rax
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
               	je	0x4003f8 <.text+0x1d8>
               	movl	$0x7, %eax
               	retq
               	movl	$0x5, %r11d
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	xorq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x1, %r11
               	imulq	%rax, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	orq	%r11, %rax
               	shrq	$0x1f, %rax
               	xorq	$0x1, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x1, %rax
               	je	0x400460 <.text+0x240>
               	movl	$0x8, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
