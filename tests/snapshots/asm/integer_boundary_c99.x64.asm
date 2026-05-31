
integer_boundary_c99.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400436 <.text+0x136>
               	movq	%rax, %rdi
               	callq	*0xfde1(%rip)           # 0x4100f8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfdce(%rip), %r9       # 0x410108
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400385 <.text+0x85>
               	leaq	0xfdad(%rip), %r9       # 0x410108
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfd8d(%rip), %rdi      # 0x410120
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfd7e(%rip), %rdi      # 0x410126
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfd70(%rip), %rdi      # 0x41012d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4025c7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400407 <.text+0x107>
               	leaq	0xfd16(%rip), %r14      # 0x410108
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400407 <.text+0x107>
               	leaq	0xfcfa(%rip), %r12      # 0x410108
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x240, %rsp            # imm = 0x240
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	jmp	0x400459 <.text+0x159>
               	movl	$0x1, %r11d
               	cmpq	$0x0, %r11
               	jne	0x4004ce <.text+0x1ce>
               	jmp	0x400486 <.text+0x186>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400459 <.text+0x159>
               	jmp	0x4004d3 <.text+0x1d3>
               	leaq	0xfccb(%rip), %r9       # 0x410158
               	movl	$0x64, %ebx
               	movl	%ebx, (%r9)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfcb3(%rip), %r15      # 0x410160
               	movl	$0x36, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4004ce <.text+0x1ce>
               	jmp	0x400471 <.text+0x171>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x400548 <.text+0x248>
               	jmp	0x4004ff <.text+0x1ff>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4004d3 <.text+0x1d3>
               	jmp	0x40054d <.text+0x24d>
               	leaq	0xfc52(%rip), %r12      # 0x410158
               	movl	$0x65, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfc54(%rip), %r12      # 0x41017b
               	movl	$0x37, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400548 <.text+0x248>
               	jmp	0x4004ea <.text+0x1ea>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x4005c1 <.text+0x2c1>
               	jmp	0x400579 <.text+0x279>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40054d <.text+0x24d>
               	jmp	0x4005c6 <.text+0x2c6>
               	leaq	0xfbd8(%rip), %r14      # 0x410158
               	movl	$0x66, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xfbf6(%rip), %r14      # 0x410196
               	movl	$0x38, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4005c1 <.text+0x2c1>
               	jmp	0x400564 <.text+0x264>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x40063a <.text+0x33a>
               	jmp	0x4005f2 <.text+0x2f2>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4005c6 <.text+0x2c6>
               	jmp	0x40063f <.text+0x33f>
               	leaq	0xfb5f(%rip), %r15      # 0x410158
               	movl	$0x67, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfb98(%rip), %r15      # 0x4101b1
               	movl	$0x39, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40063a <.text+0x33a>
               	jmp	0x4005dd <.text+0x2dd>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x4006b4 <.text+0x3b4>
               	jmp	0x40066b <.text+0x36b>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40063f <.text+0x33f>
               	jmp	0x4006b9 <.text+0x3b9>
               	leaq	0xfae6(%rip), %r12      # 0x410158
               	movl	$0x68, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfb39(%rip), %r12      # 0x4101cc
               	movl	$0x3a, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4006b4 <.text+0x3b4>
               	jmp	0x400656 <.text+0x356>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x40072d <.text+0x42d>
               	jmp	0x4006e5 <.text+0x3e5>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4006b9 <.text+0x3b9>
               	jmp	0x400732 <.text+0x432>
               	leaq	0xfa6c(%rip), %r14      # 0x410158
               	movl	$0x69, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xfadb(%rip), %r14      # 0x4101e7
               	movl	$0x3b, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40072d <.text+0x42d>
               	jmp	0x4006d0 <.text+0x3d0>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x4007a6 <.text+0x4a6>
               	jmp	0x40075e <.text+0x45e>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400732 <.text+0x432>
               	jmp	0x4007ab <.text+0x4ab>
               	leaq	0xf9f3(%rip), %r15      # 0x410158
               	movl	$0x6a, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfa7d(%rip), %r15      # 0x410202
               	movl	$0x3c, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4007a6 <.text+0x4a6>
               	jmp	0x400749 <.text+0x449>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x400829 <.text+0x529>
               	jmp	0x4007e0 <.text+0x4e0>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4007ab <.text+0x4ab>
               	movl	$0xff, %eax
               	movb	%al, -0x8(%rbp)
               	jmp	0x40082e <.text+0x52e>
               	leaq	0xf971(%rip), %r12      # 0x410158
               	movl	$0x6b, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfa15(%rip), %r12      # 0x41021d
               	movl	$0x3d, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400829 <.text+0x529>
               	jmp	0x4007c2 <.text+0x4c2>
               	movzbq	-0x8(%rbp), %rax
               	xorq	$0xff, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4008d3 <.text+0x5d3>
               	jmp	0x40088b <.text+0x58b>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40082e <.text+0x52e>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %r15
               	addq	$0x1, %r15
               	movb	%r15b, (%rax)
               	jmp	0x4008d8 <.text+0x5d8>
               	leaq	0xf8c6(%rip), %r14      # 0x410158
               	movl	$0x6e, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf986(%rip), %r14      # 0x410238
               	movl	$0x42, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4008d3 <.text+0x5d3>
               	jmp	0x400864 <.text+0x564>
               	movzbq	-0x8(%rbp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400976 <.text+0x676>
               	jmp	0x40092e <.text+0x62e>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4008d8 <.text+0x5d8>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %r15
               	addq	$-0x1, %r15
               	movb	%r15b, (%rax)
               	jmp	0x40097b <.text+0x67b>
               	leaq	0xf823(%rip), %r14      # 0x410158
               	movl	$0x6f, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf8fe(%rip), %r14      # 0x410253
               	movl	$0x44, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400976 <.text+0x676>
               	jmp	0x400907 <.text+0x607>
               	movzbq	-0x8(%rbp), %r15
               	xorq	$0xff, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400a1c <.text+0x71c>
               	jmp	0x4009d4 <.text+0x6d4>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40097b <.text+0x67b>
               	movl	$0x7f, %r10d
               	movq	%r10, 0xf8(%rsp)
               	jmp	0x400a21 <.text+0x721>
               	leaq	0xf77d(%rip), %r14      # 0x410158
               	movl	$0x70, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf873(%rip), %r14      # 0x41026e
               	movl	$0x46, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400a1c <.text+0x71c>
               	jmp	0x4009b1 <.text+0x6b1>
               	movq	0xf8(%rsp), %r15
               	movsbq	%r15b, %r15
               	cmpq	$0x7f, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400ab9 <.text+0x7b9>
               	jmp	0x400a71 <.text+0x771>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400a21 <.text+0x721>
               	movabsq	$-0x80, %rax
               	movb	%al, -0x18(%rbp)
               	jmp	0x400abe <.text+0x7be>
               	leaq	0xf6e0(%rip), %r14      # 0x410158
               	movl	$0x71, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf7f0(%rip), %r14      # 0x410289
               	movl	$0x49, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400ab9 <.text+0x7b9>
               	jmp	0x400a4e <.text+0x74e>
               	movsbq	-0x18(%rbp), %rax
               	cmpq	$-0x80, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400b54 <.text+0x854>
               	jmp	0x400b0b <.text+0x80b>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400abe <.text+0x7be>
               	leaq	-0x18(%rbp), %rax
               	movsbq	(%rax), %r15
               	addq	$-0x1, %r15
               	movb	%r15b, (%rax)
               	jmp	0x400b59 <.text+0x859>
               	leaq	0xf646(%rip), %rbx      # 0x410158
               	movl	$0x72, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf771(%rip), %rbx      # 0x4102a4
               	movl	$0x4b, %r15d
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400b54 <.text+0x854>
               	jmp	0x400ae4 <.text+0x7e4>
               	movsbq	-0x18(%rbp), %r15
               	andq	$0xff, %r15
               	xorq	$0x7f, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400bfd <.text+0x8fd>
               	jmp	0x400bb4 <.text+0x8b4>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400b59 <.text+0x859>
               	movl	$0xffff, %eax           # imm = 0xFFFF
               	movw	%ax, -0x20(%rbp)
               	jmp	0x400c02 <.text+0x902>
               	leaq	0xf59d(%rip), %rbx      # 0x410158
               	movl	$0x73, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf6e3(%rip), %rbx      # 0x4102bf
               	movl	$0x4d, %r15d
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400bfd <.text+0x8fd>
               	jmp	0x400b96 <.text+0x896>
               	movzwq	-0x20(%rbp), %rax
               	xorq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400ca9 <.text+0x9a9>
               	jmp	0x400c60 <.text+0x960>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400c02 <.text+0x902>
               	leaq	-0x20(%rbp), %rax
               	movzwq	(%rax), %r14
               	addq	$0x1, %r14
               	movw	%r14w, (%rax)
               	jmp	0x400cae <.text+0x9ae>
               	leaq	0xf4f1(%rip), %r15      # 0x410158
               	movl	$0x78, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf652(%rip), %r15      # 0x4102da
               	movl	$0x53, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400ca9 <.text+0x9a9>
               	jmp	0x400c38 <.text+0x938>
               	movzwq	-0x20(%rbp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x400d55 <.text+0xa55>
               	jmp	0x400d0c <.text+0xa0c>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400cae <.text+0x9ae>
               	xorq	%rax, %rax
               	movw	%ax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r14
               	movzwq	(%r14), %rax
               	addq	$-0x1, %rax
               	movw	%ax, (%r14)
               	jmp	0x400d5a <.text+0xa5a>
               	leaq	0xf445(%rip), %r15      # 0x410158
               	movl	$0x79, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf5c1(%rip), %r15      # 0x4102f5
               	movl	$0x55, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400d55 <.text+0xa55>
               	jmp	0x400cdd <.text+0x9dd>
               	movzwq	-0x20(%rbp), %rax
               	xorq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400dfa <.text+0xafa>
               	jmp	0x400db3 <.text+0xab3>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400d5a <.text+0xa5a>
               	movl	$0x7fff, %r10d          # imm = 0x7FFF
               	movq	%r10, 0xf0(%rsp)
               	jmp	0x400dff <.text+0xaff>
               	leaq	0xf39e(%rip), %r15      # 0x410158
               	movl	$0x7a, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf536(%rip), %r15      # 0x410310
               	movl	$0x58, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400dfa <.text+0xafa>
               	jmp	0x400d90 <.text+0xa90>
               	movq	0xf0(%rsp), %rbx
               	movswq	%bx, %rbx
               	cmpq	$0x7fff, %rbx           # imm = 0x7FFF
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400e9c <.text+0xb9c>
               	jmp	0x400e53 <.text+0xb53>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400dff <.text+0xaff>
               	movabsq	$-0x8000, %r10          # imm = 0x8000
               	movq	%r10, 0xe8(%rsp)
               	jmp	0x400ea1 <.text+0xba1>
               	leaq	0xf2fe(%rip), %r15      # 0x410158
               	movl	$0x7b, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf4b0(%rip), %r15      # 0x41032b
               	movl	$0x5b, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400e9c <.text+0xb9c>
               	jmp	0x400e2c <.text+0xb2c>
               	movq	0xe8(%rsp), %r12
               	movswq	%r12w, %r12
               	cmpq	$-0x8000, %r12          # imm = 0x8000
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400f49 <.text+0xc49>
               	jmp	0x400f01 <.text+0xc01>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400ea1 <.text+0xba1>
               	movq	0xe8(%rsp), %rax
               	movswq	%ax, %rax
               	movq	%rax, %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, 0xe0(%rsp)
               	jmp	0x400f4e <.text+0xc4e>
               	leaq	0xf250(%rip), %r15      # 0x410158
               	movl	$0x7c, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf41e(%rip), %r15      # 0x410346
               	movl	$0x5d, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400f49 <.text+0xc49>
               	jmp	0x400ece <.text+0xbce>
               	movq	0xe0(%rsp), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x8000, %rax           # imm = 0x8000
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400fff <.text+0xcff>
               	jmp	0x400fb7 <.text+0xcb7>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400f4e <.text+0xc4e>
               	movl	$0x12345, %eax          # imm = 0x12345
               	movslq	%eax, %rax
               	movswq	%ax, %r10
               	movq	%r10, 0xd8(%rsp)
               	jmp	0x401004 <.text+0xd04>
               	leaq	0xf19a(%rip), %r15      # 0x410158
               	movl	$0x7d, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf382(%rip), %r15      # 0x410361
               	movl	$0x5f, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400fff <.text+0xcff>
               	jmp	0x400f8e <.text+0xc8e>
               	movq	0xd8(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4010a4 <.text+0xda4>
               	jmp	0x40105c <.text+0xd5c>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401004 <.text+0xd04>
               	movabsq	$-0x2a, %rax
               	movswq	%ax, %r10
               	movq	%r10, 0xd0(%rsp)
               	jmp	0x4010a9 <.text+0xda9>
               	leaq	0xf0f5(%rip), %r15      # 0x410158
               	movl	$0x7e, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf2f9(%rip), %r15      # 0x41037c
               	movl	$0x64, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4010a4 <.text+0xda4>
               	jmp	0x401031 <.text+0xd31>
               	movq	0xd0(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x2a, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401157 <.text+0xe57>
               	jmp	0x40110f <.text+0xe0f>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4010a9 <.text+0xda9>
               	movl	$0xffff, %r10d          # imm = 0xFFFF
               	movq	%r10, 0xc8(%rsp)
               	movq	0xc8(%rsp), %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, 0xc0(%rsp)
               	jmp	0x40115c <.text+0xe5c>
               	leaq	0xf042(%rip), %r15      # 0x410158
               	movl	$0x7f, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf260(%rip), %r15      # 0x410397
               	movl	$0x69, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401157 <.text+0xe57>
               	jmp	0x4010d5 <.text+0xdd5>
               	movq	0xc0(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	xorq	$0xffff, %r15           # imm = 0xFFFF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4011fb <.text+0xefb>
               	jmp	0x4011b3 <.text+0xeb3>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40115c <.text+0xe5c>
               	jmp	0x401200 <.text+0xf00>
               	leaq	0xef9e(%rip), %rbx      # 0x410158
               	movl	$0x80, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf1d8(%rip), %rbx      # 0x4103b2
               	movl	$0x6e, %r12d
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4011fb <.text+0xefb>
               	jmp	0x40119e <.text+0xe9e>
               	movq	0xc8(%rsp), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpq	$0xffff, %rax           # imm = 0xFFFF
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401297 <.text+0xf97>
               	jmp	0x40124d <.text+0xf4d>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401200 <.text+0xf00>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, -0x70(%rbp)
               	jmp	0x40129c <.text+0xf9c>
               	leaq	0xef04(%rip), %r12      # 0x410158
               	movl	$0x81, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf157(%rip), %r12      # 0x4103cd
               	movl	$0x70, %r14d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401297 <.text+0xf97>
               	jmp	0x401230 <.text+0xf30>
               	movl	-0x70(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x40132d <.text+0x102d>
               	jmp	0x4012e6 <.text+0xfe6>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40129c <.text+0xf9c>
               	leaq	-0x70(%rbp), %rax
               	movl	(%rax), %ebx
               	addq	$0x1, %rbx
               	movl	%ebx, (%rax)
               	jmp	0x401332 <.text+0x1032>
               	leaq	0xee6b(%rip), %r14      # 0x410158
               	movl	$0x82, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf0db(%rip), %r14      # 0x4103e8
               	movl	$0x76, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40132d <.text+0x102d>
               	jmp	0x4012c2 <.text+0xfc2>
               	movl	-0x70(%rbp), %ebx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4013d0 <.text+0x10d0>
               	jmp	0x401389 <.text+0x1089>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401332 <.text+0x1032>
               	xorq	%rax, %rax
               	movl	%eax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rbx
               	movl	(%rbx), %eax
               	addq	$-0x1, %rax
               	movl	%eax, (%rbx)
               	jmp	0x4013d5 <.text+0x10d5>
               	leaq	0xedc8(%rip), %r14      # 0x410158
               	movl	$0x83, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf053(%rip), %r14      # 0x410403
               	movl	$0x78, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4013d0 <.text+0x10d0>
               	jmp	0x40135f <.text+0x105f>
               	movl	-0x70(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401467 <.text+0x1167>
               	jmp	0x40141e <.text+0x111e>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4013d5 <.text+0x10d5>
               	movl	$0x7fffffff, %r10d      # imm = 0x7FFFFFFF
               	movq	%r10, 0xb8(%rsp)
               	jmp	0x40146c <.text+0x116c>
               	leaq	0xed33(%rip), %r14      # 0x410158
               	movl	$0x84, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xefd8(%rip), %r14      # 0x41041e
               	movl	$0x7b, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401467 <.text+0x1167>
               	jmp	0x4013fb <.text+0x10fb>
               	movq	0xb8(%rsp), %r12
               	movslq	%r12d, %r12
               	cmpq	$0x7fffffff, %r12       # imm = 0x7FFFFFFF
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x40150a <.text+0x120a>
               	jmp	0x4014c2 <.text+0x11c2>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40146c <.text+0x116c>
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movslq	%eax, %r10
               	movq	%r10, 0xb0(%rsp)
               	jmp	0x40150f <.text+0x120f>
               	leaq	0xec8f(%rip), %r14      # 0x410158
               	movl	$0x85, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xef50(%rip), %r14      # 0x410439
               	movl	$0x7e, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40150a <.text+0x120a>
               	jmp	0x401498 <.text+0x1198>
               	movq	0xb0(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x80000000, %rax      # imm = 0x80000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4015ab <.text+0x12ab>
               	jmp	0x401563 <.text+0x1263>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40150f <.text+0x120f>
               	movq	0xb0(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0xa8(%rsp)
               	jmp	0x4015b0 <.text+0x12b0>
               	leaq	0xebee(%rip), %r14      # 0x410158
               	movl	$0x86, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xeec9(%rip), %r14      # 0x410454
               	movl	$0x80, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4015ab <.text+0x12ab>
               	jmp	0x40153b <.text+0x123b>
               	movq	0xa8(%rsp), %rbx
               	cmpq	$-0x80000000, %rbx      # imm = 0x80000000
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40164b <.text+0x134b>
               	jmp	0x401602 <.text+0x1302>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4015b0 <.text+0x12b0>
               	movq	0xb0(%rsp), %rax
               	movslq	%eax, %rax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	jmp	0x401650 <.text+0x1350>
               	leaq	0xeb4f(%rip), %r14      # 0x410158
               	movl	$0x87, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xee45(%rip), %r14      # 0x41046f
               	movl	$0x86, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40164b <.text+0x134b>
               	jmp	0x4015d9 <.text+0x12d9>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%r12, %rax
               	cmpq	%r11, %r12
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4016df <.text+0x13df>
               	jmp	0x40169c <.text+0x139c>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401650 <.text+0x1350>
               	movabsq	$-0x1, %rax
               	movq	%rax, -0x98(%rbp)
               	jmp	0x4016e4 <.text+0x13e4>
               	leaq	0xeab5(%rip), %r14      # 0x410158
               	movl	$0x88, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xedc6(%rip), %r14      # 0x41048a
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4016df <.text+0x13df>
               	jmp	0x401676 <.text+0x1376>
               	movq	-0x98(%rbp), %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x40177c <.text+0x147c>
               	jmp	0x401735 <.text+0x1435>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4016e4 <.text+0x13e4>
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%rax)
               	jmp	0x401781 <.text+0x1481>
               	leaq	0xea1c(%rip), %r14      # 0x410158
               	movl	$0x8c, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xed49(%rip), %r14      # 0x4104a5
               	movl	$0x8e, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40177c <.text+0x147c>
               	jmp	0x40170c <.text+0x140c>
               	movq	-0x98(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401819 <.text+0x1519>
               	jmp	0x4017d2 <.text+0x14d2>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401781 <.text+0x1481>
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rbx
               	addq	$-0x1, %rbx
               	movq	%rbx, (%rax)
               	jmp	0x40181e <.text+0x151e>
               	leaq	0xe97f(%rip), %r14      # 0x410158
               	movl	$0x8d, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xecc7(%rip), %r14      # 0x4104c0
               	movl	$0x90, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401819 <.text+0x1519>
               	jmp	0x4017a9 <.text+0x14a9>
               	movq	-0x98(%rbp), %rbx
               	cmpq	$-0x1, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4018b4 <.text+0x15b4>
               	jmp	0x40186d <.text+0x156d>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40181e <.text+0x151e>
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, 0xa0(%rsp)
               	jmp	0x4018b9 <.text+0x15b9>
               	leaq	0xe8e4(%rip), %r14      # 0x410158
               	movl	$0x8e, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xec47(%rip), %r14      # 0x4104db
               	movl	$0x92, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4018b4 <.text+0x15b4>
               	jmp	0x401846 <.text+0x1546>
               	movq	0xa0(%rsp), %rbx
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401958 <.text+0x1658>
               	jmp	0x40190f <.text+0x160f>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4018b9 <.text+0x15b9>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x98(%rsp)
               	jmp	0x40195d <.text+0x165d>
               	leaq	0xe842(%rip), %r14      # 0x410158
               	movl	$0x8f, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xebbf(%rip), %r14      # 0x4104f6
               	movl	$0x95, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401958 <.text+0x1658>
               	jmp	0x4018e8 <.text+0x15e8>
               	movq	0x98(%rsp), %r15
               	sarq	$0x1, %r15
               	cmpq	$-0x1, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4019f9 <.text+0x16f9>
               	jmp	0x4019b1 <.text+0x16b1>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40195d <.text+0x165d>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, 0x90(%rsp)
               	jmp	0x4019fe <.text+0x16fe>
               	leaq	0xe7a0(%rip), %r14      # 0x410158
               	movl	$0x90, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xeb39(%rip), %r14      # 0x410511
               	movl	$0x9a, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4019f9 <.text+0x16f9>
               	jmp	0x40198a <.text+0x168a>
               	movq	0x90(%rsp), %r12
               	shrq	$0x1, %r12
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	cmpq	%r11, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401aa0 <.text+0x17a0>
               	jmp	0x401a58 <.text+0x1758>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4019fe <.text+0x16fe>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x88(%rsp)
               	jmp	0x401aa5 <.text+0x17a5>
               	leaq	0xe6f9(%rip), %r14      # 0x410158
               	movl	$0x91, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xeaac(%rip), %r14      # 0x41052c
               	movl	$0x9d, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401aa0 <.text+0x17a0>
               	jmp	0x401a31 <.text+0x1731>
               	movq	0x88(%rsp), %rbx
               	shrq	$0x20, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401b55 <.text+0x1855>
               	jmp	0x401b0c <.text+0x180c>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401aa5 <.text+0x17a5>
               	movabsq	$-0x12c, %r10           # imm = 0xFED4
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %r15
               	movslq	%r15d, %r15
               	movsbq	%r15b, %r10
               	movq	%r10, 0x80(%rsp)
               	jmp	0x401b5a <.text+0x185a>
               	leaq	0xe645(%rip), %r14      # 0x410158
               	movl	$0x92, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xea13(%rip), %r14      # 0x410547
               	movl	$0xa0, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401b55 <.text+0x1855>
               	jmp	0x401ad4 <.text+0x17d4>
               	movq	0x80(%rsp), %r14
               	movsbq	%r14b, %r14
               	movl	$0xd4, %ebx
               	movsbq	%bl, %rbx
               	cmpq	%rbx, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401be9 <.text+0x18e9>
               	jmp	0x401ba1 <.text+0x18a1>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401b5a <.text+0x185a>
               	jmp	0x401bee <.text+0x18ee>
               	leaq	0xe5b0(%rip), %rbx      # 0x410158
               	movl	$0x96, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xe99a(%rip), %rbx      # 0x410562
               	movl	$0xa9, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401be9 <.text+0x18e9>
               	jmp	0x401b8c <.text+0x188c>
               	movq	0x80(%rsp), %rax
               	movsbq	%al, %rax
               	cmpq	$-0x2c, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401c91 <.text+0x1991>
               	jmp	0x401c47 <.text+0x1947>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401bee <.text+0x18ee>
               	movq	0x78(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x70(%rsp)
               	jmp	0x401c96 <.text+0x1996>
               	leaq	0xe50a(%rip), %r12      # 0x410158
               	movl	$0x97, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe90d(%rip), %r12      # 0x41057d
               	movl	$0xaa, %r15d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401c91 <.text+0x1991>
               	jmp	0x401c1b <.text+0x191b>
               	movq	0x70(%rsp), %rax
               	andq	$0xff, %rax
               	xorq	$0xd4, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401d32 <.text+0x1a32>
               	jmp	0x401ce8 <.text+0x19e8>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401c96 <.text+0x1996>
               	jmp	0x401d37 <.text+0x1a37>
               	leaq	0xe469(%rip), %r12      # 0x410158
               	movl	$0x98, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe887(%rip), %r12      # 0x410598
               	movl	$0xaf, %r14d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401d32 <.text+0x1a32>
               	jmp	0x401cd3 <.text+0x19d3>
               	movq	0x70(%rsp), %rax
               	andq	$0xff, %rax
               	cmpq	$0xd4, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401dd1 <.text+0x1ad1>
               	jmp	0x401d8a <.text+0x1a8a>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401d37 <.text+0x1a37>
               	movl	$0x12345, %eax          # imm = 0x12345
               	movslq	%eax, %rax
               	movswq	%ax, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	0x401dd6 <.text+0x1ad6>
               	leaq	0xe3c7(%rip), %r14      # 0x410158
               	movl	$0x99, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe802(%rip), %r14      # 0x4105b3
               	movl	$0xb0, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401dd1 <.text+0x1ad1>
               	jmp	0x401d64 <.text+0x1a64>
               	movq	0x68(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401e5d <.text+0x1b5d>
               	jmp	0x401e15 <.text+0x1b15>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401dd6 <.text+0x1ad6>
               	jmp	0x401e62 <.text+0x1b62>
               	leaq	0xe33c(%rip), %r14      # 0x410158
               	movl	$0x9a, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe792(%rip), %r14      # 0x4105ce
               	movl	$0xb5, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401e5d <.text+0x1b5d>
               	jmp	0x401e00 <.text+0x1b00>
               	movq	0x68(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$0x2345, %rax           # imm = 0x2345
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401efa <.text+0x1bfa>
               	jmp	0x401eb2 <.text+0x1bb2>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401e62 <.text+0x1b62>
               	movl	$0x1ffff, %eax          # imm = 0x1FFFF
               	movslq	%eax, %rax
               	movswq	%ax, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	0x401eff <.text+0x1bff>
               	leaq	0xe29f(%rip), %r15      # 0x410158
               	movl	$0x9b, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xe710(%rip), %r15      # 0x4105e9
               	movl	$0xb6, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401efa <.text+0x1bfa>
               	jmp	0x401e8c <.text+0x1b8c>
               	movq	0x60(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401f86 <.text+0x1c86>
               	jmp	0x401f3e <.text+0x1c3e>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401eff <.text+0x1bff>
               	jmp	0x401f8b <.text+0x1c8b>
               	leaq	0xe213(%rip), %r15      # 0x410158
               	movl	$0x9c, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xe69e(%rip), %r15      # 0x410604
               	movl	$0xba, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401f86 <.text+0x1c86>
               	jmp	0x401f29 <.text+0x1c29>
               	movq	0x60(%rsp), %rax
               	movswq	%ax, %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x402029 <.text+0x1d29>
               	jmp	0x401fe0 <.text+0x1ce0>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401f8b <.text+0x1c8b>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x50(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x58(%rsp)
               	jmp	0x40202e <.text+0x1d2e>
               	leaq	0xe171(%rip), %rbx      # 0x410158
               	movl	$0x9d, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xe617(%rip), %rbx      # 0x41061f
               	movl	$0xbb, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x402029 <.text+0x1d29>
               	jmp	0x401fb5 <.text+0x1cb5>
               	movq	0x50(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movq	0x58(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	%r14, %rbx
               	seta	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4020f0 <.text+0x1df0>
               	jmp	0x4020a8 <.text+0x1da8>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40202e <.text+0x1d2e>
               	movq	0x50(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x48(%rsp)
               	jmp	0x4020f5 <.text+0x1df5>
               	leaq	0xe0a9(%rip), %r14      # 0x410158
               	movl	$0xa0, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xe56b(%rip), %r14      # 0x41063a
               	movl	$0xc2, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4020f0 <.text+0x1df0>
               	jmp	0x402067 <.text+0x1d67>
               	movq	0x40(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x48(%rsp), %r15
               	movslq	%r15d, %r15
               	cmpq	%r15, %rax
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x40218a <.text+0x1e8a>
               	jmp	0x402142 <.text+0x1e42>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4020f5 <.text+0x1df5>
               	movl	$0x1, %r10d
               	movq	%r10, 0x38(%rsp)
               	jmp	0x40218f <.text+0x1e8f>
               	leaq	0xe00f(%rip), %r15      # 0x410158
               	movl	$0xa1, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe4eb(%rip), %r15      # 0x410655
               	movl	$0xc5, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40218a <.text+0x1e8a>
               	jmp	0x402122 <.text+0x1e22>
               	movq	0x38(%rsp), %rbx
               	movslq	%ebx, %rbx
               	shlq	$0x1e, %rbx
               	cmpq	$0x40000000, %rbx       # imm = 0x40000000
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x402225 <.text+0x1f25>
               	jmp	0x4021dc <.text+0x1edc>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40218f <.text+0x1e8f>
               	movl	$0x1, %r10d
               	movq	%r10, 0x30(%rsp)
               	jmp	0x40222a <.text+0x1f2a>
               	leaq	0xdf75(%rip), %r15      # 0x410158
               	movl	$0xaa, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe46c(%rip), %r15      # 0x410670
               	movl	$0xcd, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x402225 <.text+0x1f25>
               	jmp	0x4021bc <.text+0x1ebc>
               	movq	0x30(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	shlq	$0x1f, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4022d4 <.text+0x1fd4>
               	jmp	0x40228c <.text+0x1f8c>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40222a <.text+0x1f2a>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x28(%rsp)
               	jmp	0x4022d9 <.text+0x1fd9>
               	leaq	0xdec5(%rip), %r15      # 0x410158
               	movl	$0xab, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xe3d8(%rip), %r15      # 0x41068b
               	movl	$0xcf, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4022d4 <.text+0x1fd4>
               	jmp	0x402268 <.text+0x1f68>
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	cmpq	$-0x1, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x40236a <.text+0x206a>
               	jmp	0x402322 <.text+0x2022>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4022d9 <.text+0x1fd9>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x20(%rsp)
               	jmp	0x40236f <.text+0x206f>
               	leaq	0xde2f(%rip), %r15      # 0x410158
               	movl	$0xac, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe35c(%rip), %r15      # 0x4106a6
               	movl	$0xd3, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40236a <.text+0x206a>
               	jmp	0x402302 <.text+0x2002>
               	movq	0x20(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x402415 <.text+0x2115>
               	jmp	0x4023cc <.text+0x20cc>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40236f <.text+0x206f>
               	leaq	0xdda1(%rip), %rax      # 0x410158
               	movslq	(%rax), %r14
               	cmpq	$0x0, %r14
               	jne	0x402453 <.text+0x2153>
               	jmp	0x40241a <.text+0x211a>
               	leaq	0xdd85(%rip), %r15      # 0x410158
               	movl	$0xad, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe2cd(%rip), %r15      # 0x4106c1
               	movl	$0xd5, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4025cd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x402415 <.text+0x2115>
               	jmp	0x4023a0 <.text+0x20a0>
               	leaq	0xe2bb(%rip), %r12      # 0x4106dc
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x4025d3 <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	leaq	0xdcfe(%rip), %r12      # 0x410158
               	movslq	(%r12), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
