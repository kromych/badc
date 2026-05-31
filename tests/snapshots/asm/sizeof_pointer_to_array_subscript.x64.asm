
sizeof_pointer_to_array_subscript.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	leaq	-0x70(%rbp), %r11
               	leaq	0x10306(%rip), %r9      # 0x410553
               	movq	%r9, (%r11)
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x8, %r9
               	leaq	0x102fb(%rip), %r8      # 0x410560
               	movq	%r8, (%r9)
               	leaq	-0x70(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x10, %r8
               	leaq	0x102f3(%rip), %r11     # 0x410570
               	movq	%r11, (%r8)
               	leaq	-0x70(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x18, %r11
               	leaq	0x102fb(%rip), %r9      # 0x410590
               	movq	%r9, (%r11)
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x20, %r9
               	leaq	0x10323(%rip), %r8      # 0x4105d0
               	movq	%r8, (%r9)
               	leaq	-0x70(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x28, %r8
               	leaq	0x1034b(%rip), %r11     # 0x410610
               	movq	%r11, (%r8)
               	leaq	-0x70(%rbp), %r9
               	movq	(%r9), %r11
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	leaq	-0x70(%rbp), %r11
               	movq	(%r11), %r8
               	movq	%r9, %r11
               	subq	%r8, %r11
               	cmpq	$0x8, %r11
               	je	0x400301 <.text+0xe1>
               	movl	$0xb, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r8
               	movq	%r8, %rax
               	addq	$0x10, %rax
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	cmpq	$0x10, %r9
               	je	0x40034e <.text+0x12e>
               	movl	$0xc, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r8
               	movq	%r8, %rax
               	addq	$0x20, %rax
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x10, %r9
               	movq	(%r9), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	cmpq	$0x20, %r9
               	je	0x40039b <.text+0x17b>
               	movl	$0xd, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r8
               	movq	%r8, %rax
               	addq	$0x40, %rax
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x18, %r9
               	movq	(%r9), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	cmpq	$0x40, %r9
               	je	0x4003e8 <.text+0x1c8>
               	movl	$0xe, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %r8
               	movq	%r8, %rax
               	addq	$0x3c, %rax
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x20, %r9
               	movq	(%r9), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	cmpq	$0x3c, %r9
               	je	0x400435 <.text+0x215>
               	movl	$0xf, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %r8
               	movq	%r8, %rax
               	addq	$0x14, %rax
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x20, %r9
               	movq	(%r9), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	cmpq	$0x14, %r9
               	je	0x400482 <.text+0x262>
               	movl	$0x10, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r8
               	movq	%r8, %rax
               	addq	$0x18, %rax
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x28, %r9
               	movq	(%r9), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	cmpq	$0x18, %r9
               	je	0x4004cf <.text+0x2af>
               	movl	$0x11, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r8
               	movq	%r8, %rax
               	addq	$0xc, %rax
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x28, %r9
               	movq	(%r9), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	cmpq	$0xc, %r9
               	je	0x40051c <.text+0x2fc>
               	movl	$0x12, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r8
               	movq	%r8, %rax
               	addq	$0x4, %rax
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x28, %r9
               	movq	(%r9), %r8
               	movq	%rax, %r9
               	subq	%r8, %r9
               	cmpq	$0x4, %r9
               	je	0x400569 <.text+0x349>
               	movl	$0x13, %eax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movl	%r8d, -0x78(%rbp)
               	jmp	0x400575 <.text+0x355>
               	movslq	-0x78(%rbp), %r8
               	cmpq	$0x8, %r8
               	jge	0x4005e0 <.text+0x3c0>
               	jmp	0x4005a4 <.text+0x384>
               	leaq	-0x78(%rbp), %r8
               	movslq	(%r8), %rax
               	movq	%rax, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	0x400575 <.text+0x355>
               	leaq	-0x70(%rbp), %r9
               	movq	%r9, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r9
               	movslq	-0x78(%rbp), %rax
               	movq	%rax, %r8
               	shlq	$0x1, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	%rax, %r8
               	addq	$0x3e8, %r8             # imm = 0x3E8
               	movslq	%r8d, %r8
               	movswq	%r8w, %r8
               	movw	%r8w, (%rdi)
               	jmp	0x40058b <.text+0x36b>
               	xorq	%r8, %r8
               	movl	%r8d, -0x78(%rbp)
               	jmp	0x4005ec <.text+0x3cc>
               	movslq	-0x78(%rbp), %r8
               	cmpq	$0x8, %r8
               	jge	0x400660 <.text+0x440>
               	jmp	0x40061b <.text+0x3fb>
               	leaq	-0x78(%rbp), %r8
               	movslq	(%r8), %rax
               	movq	%rax, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r8)
               	jmp	0x4005ec <.text+0x3cc>
               	leaq	-0x70(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rdi
               	movslq	-0x78(%rbp), %rax
               	movq	%rax, %r8
               	shlq	$0x1, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movswq	(%r9), %r8
               	movq	%rax, %r9
               	addq	$0x3e8, %r9             # imm = 0x3E8
               	movslq	%r9d, %r9
               	movswq	%r9w, %r9
               	cmpq	%r9, %r8
               	je	0x400686 <.text+0x466>
               	jmp	0x40066c <.text+0x44c>
               	xorq	%r9, %r9
               	movl	%r9d, -0x78(%rbp)
               	jmp	0x40068b <.text+0x46b>
               	movslq	-0x78(%rbp), %r9
               	movq	%r9, %rax
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	0x400602 <.text+0x3e2>
               	movslq	-0x78(%rbp), %r9
               	cmpq	$0x8, %r9
               	jge	0x4006ff <.text+0x4df>
               	jmp	0x4006ba <.text+0x49a>
               	leaq	-0x78(%rbp), %r9
               	movslq	(%r9), %rax
               	movq	%rax, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	0x40068b <.text+0x46b>
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r8
               	movslq	-0x78(%rbp), %rax
               	movq	%rax, %r9
               	shlq	$0x1, %r9
               	movq	%r8, %rdi
               	addq	%r9, %rdi
               	movswq	(%rdi), %r9
               	movq	%rax, %rdi
               	addq	$0x3e8, %rdi            # imm = 0x3E8
               	movslq	%edi, %rdi
               	movswq	%di, %rdi
               	cmpq	%rdi, %r9
               	je	0x400724 <.text+0x504>
               	jmp	0x40070a <.text+0x4ea>
               	xorq	%rdi, %rdi
               	movl	%edi, -0x78(%rbp)
               	jmp	0x400729 <.text+0x509>
               	movslq	-0x78(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x1c, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	0x4006a1 <.text+0x481>
               	movslq	-0x78(%rbp), %rdi
               	cmpq	$0x3, %rdi
               	jge	0x400764 <.text+0x544>
               	jmp	0x400758 <.text+0x538>
               	leaq	-0x78(%rbp), %rdi
               	movslq	(%rdi), %rax
               	movq	%rax, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdi)
               	jmp	0x400729 <.text+0x509>
               	xorq	%r9, %r9
               	movl	%r9d, -0x80(%rbp)
               	jmp	0x40076f <.text+0x54f>
               	xorq	%rax, %rax
               	movl	%eax, -0x78(%rbp)
               	jmp	0x4007f5 <.text+0x5d5>
               	movslq	-0x80(%rbp), %r9
               	cmpq	$0x5, %r9
               	jge	0x4007f0 <.text+0x5d0>
               	jmp	0x40079e <.text+0x57e>
               	leaq	-0x80(%rbp), %r9
               	movslq	(%r9), %rax
               	movq	%rax, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r9)
               	jmp	0x40076f <.text+0x54f>
               	leaq	-0x70(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rdi
               	movslq	-0x78(%rbp), %rax
               	movl	$0x14, %r9d
               	imulq	%rax, %r9
               	movq	%rdi, %r8
               	addq	%r9, %r8
               	movslq	-0x80(%rbp), %r9
               	movq	%r9, %rdi
               	shlq	$0x2, %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movl	$0x64, %edi
               	imulq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%rsi)
               	jmp	0x400785 <.text+0x565>
               	jmp	0x40073f <.text+0x51f>
               	movslq	-0x78(%rbp), %rax
               	cmpq	$0x3, %rax
               	jge	0x40082e <.text+0x60e>
               	jmp	0x400823 <.text+0x603>
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%rax)
               	jmp	0x4007f5 <.text+0x5d5>
               	xorq	%rsi, %rsi
               	movl	%esi, -0x80(%rbp)
               	jmp	0x40083a <.text+0x61a>
               	xorq	%r8, %r8
               	movl	%r8d, -0x78(%rbp)
               	jmp	0x400902 <.text+0x6e2>
               	movslq	-0x80(%rbp), %rsi
               	cmpq	$0x5, %rsi
               	jge	0x4008c4 <.text+0x6a4>
               	jmp	0x400868 <.text+0x648>
               	leaq	-0x80(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	movq	%rdi, %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rsi)
               	jmp	0x40083a <.text+0x61a>
               	leaq	-0x70(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x20, %rdi
               	movq	(%rdi), %rax
               	movslq	-0x78(%rbp), %rdi
               	movl	$0x14, %esi
               	imulq	%rdi, %rsi
               	movq	%rax, %r9
               	addq	%rsi, %r9
               	movslq	-0x80(%rbp), %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	movq	%r9, %r8
               	addq	%rax, %r8
               	movslq	(%r8), %rax
               	movl	$0x64, %r8d
               	imulq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %rdi
               	addq	%rsi, %rdi
               	movslq	%edi, %rdi
               	cmpq	%rdi, %rax
               	je	0x4008fd <.text+0x6dd>
               	jmp	0x4008c9 <.text+0x6a9>
               	jmp	0x40080b <.text+0x5eb>
               	movslq	-0x78(%rbp), %rdi
               	movl	$0x5, %r8d
               	imulq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %rdi
               	addq	$0x28, %rdi
               	movslq	%edi, %rdi
               	movslq	-0x80(%rbp), %r8
               	movq	%rdi, %rax
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	0x400850 <.text+0x630>
               	movslq	-0x78(%rbp), %r8
               	cmpq	$0x3, %r8
               	jge	0x40093c <.text+0x71c>
               	jmp	0x400931 <.text+0x711>
               	leaq	-0x78(%rbp), %r8
               	movslq	(%r8), %rax
               	movq	%rax, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r8)
               	jmp	0x400902 <.text+0x6e2>
               	xorq	%rdi, %rdi
               	movl	%edi, -0x80(%rbp)
               	jmp	0x400948 <.text+0x728>
               	xorq	%r9, %r9
               	movl	%r9d, -0x78(%rbp)
               	jmp	0x400a11 <.text+0x7f1>
               	movslq	-0x80(%rbp), %rdi
               	cmpq	$0x5, %rdi
               	jge	0x4009d3 <.text+0x7b3>
               	jmp	0x400977 <.text+0x757>
               	leaq	-0x80(%rbp), %rdi
               	movslq	(%rdi), %rax
               	movq	%rax, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	0x400948 <.text+0x728>
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %r8
               	movslq	-0x78(%rbp), %rax
               	movl	$0x14, %edi
               	imulq	%rax, %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	-0x80(%rbp), %rdi
               	movq	%rdi, %r8
               	shlq	$0x2, %r8
               	movq	%rsi, %r9
               	addq	%r8, %r9
               	movslq	(%r9), %r8
               	movl	$0x64, %r9d
               	imulq	%rax, %r9
               	movslq	%r9d, %r9
               	movq	%r9, %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %r8
               	je	0x400a0c <.text+0x7ec>
               	jmp	0x4009d8 <.text+0x7b8>
               	jmp	0x400918 <.text+0x6f8>
               	movslq	-0x78(%rbp), %rax
               	movl	$0x5, %r9d
               	imulq	%rax, %r9
               	movslq	%r9d, %r9
               	movq	%r9, %rax
               	addq	$0x3c, %rax
               	movslq	%eax, %rax
               	movslq	-0x80(%rbp), %r9
               	movq	%rax, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	0x40095e <.text+0x73e>
               	movslq	-0x78(%rbp), %r9
               	cmpq	$0x2, %r9
               	jge	0x400a4c <.text+0x82c>
               	jmp	0x400a40 <.text+0x820>
               	leaq	-0x78(%rbp), %r9
               	movslq	(%r9), %rax
               	movq	%rax, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	0x400a11 <.text+0x7f1>
               	xorq	%r8, %r8
               	movl	%r8d, -0x80(%rbp)
               	jmp	0x400a58 <.text+0x838>
               	xorq	%r8, %r8
               	movl	%r8d, -0x78(%rbp)
               	jmp	0x400b42 <.text+0x922>
               	movslq	-0x80(%rbp), %r8
               	cmpq	$0x3, %r8
               	jge	0x400a96 <.text+0x876>
               	jmp	0x400a87 <.text+0x867>
               	leaq	-0x80(%rbp), %r8
               	movslq	(%r8), %rax
               	movq	%rax, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	0x400a58 <.text+0x838>
               	xorq	%r9, %r9
               	movl	%r9d, -0x88(%rbp)
               	jmp	0x400a9b <.text+0x87b>
               	jmp	0x400a27 <.text+0x807>
               	movslq	-0x88(%rbp), %r9
               	cmpq	$0x4, %r9
               	jge	0x400b3d <.text+0x91d>
               	jmp	0x400ad0 <.text+0x8b0>
               	leaq	-0x88(%rbp), %r9
               	movslq	(%r9), %rax
               	movq	%rax, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	0x400a9b <.text+0x87b>
               	leaq	-0x70(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r8
               	movslq	-0x78(%rbp), %rax
               	movl	$0xc, %r9d
               	imulq	%rax, %r9
               	movq	%r8, %rax
               	addq	%r9, %rax
               	movslq	-0x80(%rbp), %r8
               	movq	%r8, %rdi
               	shlq	$0x2, %rdi
               	movq	%rax, %r8
               	addq	%rdi, %r8
               	movslq	-0x88(%rbp), %rax
               	movq	%r8, %rsi
               	addq	%rax, %rsi
               	movslq	%r9d, %r9
               	movslq	%edi, %rdi
               	movq	%r9, %r8
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rsi)
               	jmp	0x400ab4 <.text+0x894>
               	jmp	0x400a6e <.text+0x84e>
               	movslq	-0x78(%rbp), %r8
               	cmpq	$0x2, %r8
               	jge	0x400b7c <.text+0x95c>
               	jmp	0x400b71 <.text+0x951>
               	leaq	-0x78(%rbp), %r8
               	movslq	(%r8), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%r8)
               	jmp	0x400b42 <.text+0x922>
               	xorq	%rsi, %rsi
               	movl	%esi, -0x80(%rbp)
               	jmp	0x400b87 <.text+0x967>
               	xorq	%rsi, %rsi
               	movl	%esi, -0x78(%rbp)
               	jmp	0x400ccd <.text+0xaad>
               	movslq	-0x80(%rbp), %rsi
               	cmpq	$0x3, %rsi
               	jge	0x400bc5 <.text+0x9a5>
               	jmp	0x400bb6 <.text+0x996>
               	leaq	-0x80(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	movq	%rdi, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rsi)
               	jmp	0x400b87 <.text+0x967>
               	xorq	%r8, %r8
               	movl	%r8d, -0x88(%rbp)
               	jmp	0x400bca <.text+0x9aa>
               	jmp	0x400b58 <.text+0x938>
               	movslq	-0x88(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	0x400c76 <.text+0xa56>
               	jmp	0x400bff <.text+0x9df>
               	leaq	-0x88(%rbp), %r8
               	movslq	(%r8), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%r8)
               	jmp	0x400bca <.text+0x9aa>
               	leaq	-0x70(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x28, %rdi
               	movq	(%rdi), %rsi
               	movslq	-0x78(%rbp), %rdi
               	movl	$0xc, %r8d
               	imulq	%rdi, %r8
               	movq	%rsi, %rdi
               	addq	%r8, %rdi
               	movslq	-0x80(%rbp), %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	movq	%rdi, %rsi
               	addq	%rax, %rsi
               	movslq	-0x88(%rbp), %rdi
               	movq	%rsi, %r9
               	addq	%rdi, %r9
               	movzbq	(%r9), %rsi
               	movslq	%r8d, %r8
               	movslq	%eax, %rax
               	movq	%r8, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movq	%r9, %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	andq	$0xff, %r9
               	cmpq	%r9, %rsi
               	je	0x400cc8 <.text+0xaa8>
               	jmp	0x400c7b <.text+0xa5b>
               	jmp	0x400b9d <.text+0x97d>
               	movslq	-0x78(%rbp), %r9
               	movl	$0xc, %eax
               	imulq	%r9, %rax
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	addq	$0x50, %r9
               	movslq	%r9d, %r9
               	movslq	-0x80(%rbp), %rax
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	movslq	%esi, %rsi
               	movq	%r9, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movslq	-0x88(%rbp), %rsi
               	movq	%rax, %r9
               	addq	%rsi, %r9
               	movslq	%r9d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	0x400be3 <.text+0x9c3>
               	movslq	-0x78(%rbp), %rsi
               	cmpq	$0x2, %rsi
               	jge	0x400d08 <.text+0xae8>
               	jmp	0x400cfc <.text+0xadc>
               	leaq	-0x78(%rbp), %rsi
               	movslq	(%rsi), %rax
               	movq	%rax, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rsi)
               	jmp	0x400ccd <.text+0xaad>
               	xorq	%r9, %r9
               	movl	%r9d, -0x80(%rbp)
               	jmp	0x400d17 <.text+0xaf7>
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x80(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	0x400d54 <.text+0xb34>
               	jmp	0x400d46 <.text+0xb26>
               	leaq	-0x80(%rbp), %r9
               	movslq	(%r9), %rax
               	movq	%rax, %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%r9)
               	jmp	0x400d17 <.text+0xaf7>
               	xorq	%rsi, %rsi
               	movl	%esi, -0x88(%rbp)
               	jmp	0x400d59 <.text+0xb39>
               	jmp	0x400ce3 <.text+0xac3>
               	movslq	-0x88(%rbp), %rsi
               	cmpq	$0x4, %rsi
               	jge	0x400e04 <.text+0xbe4>
               	jmp	0x400d8e <.text+0xb6e>
               	leaq	-0x88(%rbp), %rsi
               	movslq	(%rsi), %rax
               	movq	%rax, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rsi)
               	jmp	0x400d59 <.text+0xb39>
               	leaq	-0x70(%rbp), %r9
               	movq	%r9, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r9
               	movslq	-0x78(%rbp), %rax
               	movl	$0xc, %esi
               	imulq	%rax, %rsi
               	movq	%r9, %rax
               	addq	%rsi, %rax
               	movslq	-0x80(%rbp), %r9
               	movq	%r9, %rdi
               	shlq	$0x2, %rdi
               	movq	%rax, %r9
               	addq	%rdi, %r9
               	movslq	-0x88(%rbp), %rax
               	movq	%r9, %r8
               	addq	%rax, %r8
               	movzbq	(%r8), %r9
               	movslq	%esi, %rsi
               	movslq	%edi, %rdi
               	movq	%rsi, %r8
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r8
               	andq	$0xff, %r8
               	cmpq	%r8, %r9
               	je	0x400e56 <.text+0xc36>
               	jmp	0x400e09 <.text+0xbe9>
               	jmp	0x400d2d <.text+0xb0d>
               	movslq	-0x78(%rbp), %r8
               	movl	$0xc, %edi
               	imulq	%r8, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r8
               	addq	$0x6e, %r8
               	movslq	%r8d, %r8
               	movslq	-0x80(%rbp), %rdi
               	movq	%rdi, %r9
               	shlq	$0x2, %r9
               	movslq	%r9d, %r9
               	movq	%r8, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	movslq	-0x88(%rbp), %r9
               	movq	%rdi, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	jmp	0x400d72 <.text+0xb52>
               	orb	(%r9), %cl
               	jbe	0x400e93 <.text+0xc73>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400f1a <.text+0xcfa>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400f11 <.text+0xcf1>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400f15 <.text+0xcf5>
               	andb	%ch, 0x74(%rax)
               	je	0x400f25 <.text+0xd05>
               	jae	0x400ef1 <.text+0xcd1>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400f2d <.text+0xd0d>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400f97 <exit>
               	movzbq	%al, %rax
               	movq	%rax, %r9
               	xorq	%r9, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x400f4b <.text+0xd2b>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400fd2 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400fc9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400fcd <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x400fdd <exit+0x46>
               	jae	0x400fa9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400fe5 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xf123(%rip)           # 0x4100c0
