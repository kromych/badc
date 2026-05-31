
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
               	movabsq	$-0x1, %r8
               	imulq	%r9, %r8
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r8, %r9
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r9, %r8
               	cmpq	%r10, %r9
               	je	0x400275 <.text+0x55>
               	movl	$0x1, %eax
               	retq
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	movabsq	$-0x1, %rax
               	imulq	%r8, %rax
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rax, %rdi
               	movq	%r8, %rax
               	orq	%rdi, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%rax, %rdi
               	cmpq	%r10, %rax
               	je	0x4002b2 <.text+0x92>
               	movl	$0x2, %eax
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	movabsq	$-0x1, %rax
               	imulq	%rdi, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	movq	%rdi, %rax
               	orq	%r8, %rax
               	movq	%rax, %r8
               	shrq	$0x1f, %r8
               	cmpq	$0x1, %r8
               	je	0x4002f5 <.text+0xd5>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	retq
               	xorq	%rax, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	movabsq	$-0x1, %rax
               	imulq	%r8, %rax
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rax, %rdi
               	movq	%r8, %rax
               	orq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1f, %rdi
               	cmpq	$0x0, %rdi
               	je	0x40033a <.text+0x11a>
               	movl	$0x4, %edi
               	movq	%rdi, %rax
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x1, %rdi
               	imulq	%rax, %rdi
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rdi, %r8
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r8, %rdi
               	movq	%rax, %rsi
               	orq	%rdi, %rsi
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%rsi, %rdi
               	cmpq	%r10, %rsi
               	je	0x40037f <.text+0x15f>
               	movl	$0x5, %eax
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r8, %rax
               	movq	%rdi, %r8
               	orq	%rax, %r8
               	movq	%r8, %rax
               	shrq	$0x1f, %rax
               	cmpq	$0x1, %rax
               	je	0x4003af <.text+0x18f>
               	movl	$0x6, %eax
               	retq
               	movl	$0x1, %r8d
               	xorq	%rax, %rax
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r8, %rdi
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	movq	%rdi, %rax
               	xorq	%r8, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	movabsq	$-0x1, %rax
               	imulq	%r8, %rax
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rax, %rdi
               	movq	%r8, %rax
               	orq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1f, %rdi
               	movq	%rdi, %rax
               	xorq	$0x1, %rax
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400423 <.text+0x203>
               	movl	$0x7, %edi
               	movq	%rdi, %rax
               	retq
               	movl	$0x5, %eax
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rax, %rdi
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	movq	%rdi, %rax
               	xorq	%r8, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	movabsq	$-0x1, %rax
               	imulq	%r8, %rax
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rax, %rdi
               	movq	%r8, %rax
               	orq	%rdi, %rax
               	movq	%rax, %rdi
               	shrq	$0x1f, %rdi
               	movq	%rdi, %rax
               	xorq	$0x1, %rax
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rax, %rdi
               	cmpq	$0x1, %rdi
               	je	0x400493 <.text+0x273>
               	movl	$0x8, %edi
               	movq	%rdi, %rax
               	retq
               	xorq	%rax, %rax
               	retq
