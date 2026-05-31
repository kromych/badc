
zero_sign_extension_32bit.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400476 <.text+0x136>
               	movq	%rax, %rdi
               	callq	*0xfda9(%rip)           # 0x410100
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfd96(%rip), %r9       # 0x410110
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x4003c5 <.text+0x85>
               	leaq	0xfd75(%rip), %r9       # 0x410110
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
               	leaq	0xfd55(%rip), %rdi      # 0x410128
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfd46(%rip), %rdi      # 0x41012e
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfd38(%rip), %rdi      # 0x410135
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x401487 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400447 <.text+0x107>
               	leaq	0xfcde(%rip), %r14      # 0x410110
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400447 <.text+0x107>
               	leaq	0xfcc2(%rip), %r12      # 0x410110
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
               	subq	$0x1d0, %rsp            # imm = 0x1D0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movabsq	$-0x1, %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xc8(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0xc0(%rsp)
               	jmp	0x4004be <.text+0x17e>
               	movq	0xc0(%rsp), %r8
               	cmpq	$-0x1, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400545 <.text+0x205>
               	jmp	0x4004fc <.text+0x1bc>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4004be <.text+0x17e>
               	jmp	0x40054a <.text+0x20a>
               	leaq	0xfc5d(%rip), %rdi      # 0x410160
               	movl	$0x1, %r14d
               	movl	%r14d, (%rdi)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xfc44(%rip), %r15      # 0x410168
               	movl	$0x1b, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400545 <.text+0x205>
               	jmp	0x4004e7 <.text+0x1a7>
               	movq	0xc8(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4005f6 <.text+0x2b6>
               	jmp	0x4005b2 <.text+0x272>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40054a <.text+0x20a>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0xb8(%rsp)
               	movq	0xb8(%rsp), %r10
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r10
               	movq	%r10, 0xb0(%rsp)
               	jmp	0x4005fb <.text+0x2bb>
               	leaq	0xfba7(%rip), %r12      # 0x410160
               	movl	$0x2, %r14d
               	movl	%r14d, (%r12)
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xfba9(%rip), %r15      # 0x41017e
               	movl	$0x1c, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4005f6 <.text+0x2b6>
               	jmp	0x400576 <.text+0x236>
               	movq	0xb0(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400684 <.text+0x344>
               	jmp	0x40063b <.text+0x2fb>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4005fb <.text+0x2bb>
               	jmp	0x400689 <.text+0x349>
               	leaq	0xfb1e(%rip), %r12      # 0x410160
               	movl	$0x3, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfb30(%rip), %r12      # 0x410194
               	movl	$0x20, %ebx
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400684 <.text+0x344>
               	jmp	0x400626 <.text+0x2e6>
               	movq	0xb8(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400749 <.text+0x409>
               	jmp	0x400700 <.text+0x3c0>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400689 <.text+0x349>
               	movabsq	$-0x7, %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	0xa8(%rsp), %r14
               	movslq	%r14d, %r14
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r14, %r10
               	movq	%r10, 0xa0(%rsp)
               	jmp	0x40074e <.text+0x40e>
               	leaq	0xfa59(%rip), %rbx      # 0x410160
               	movl	$0x4, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xfa82(%rip), %rbx      # 0x4101aa
               	movl	$0x21, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400749 <.text+0x409>
               	jmp	0x4006bd <.text+0x37d>
               	movq	0xa0(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4007fc <.text+0x4bc>
               	jmp	0x4007b3 <.text+0x473>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40074e <.text+0x40e>
               	movq	0xa0(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x98(%rsp)
               	jmp	0x400801 <.text+0x4c1>
               	leaq	0xf9a6(%rip), %r12      # 0x410160
               	movl	$0xa, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf9e5(%rip), %r12      # 0x4101c0
               	movl	$0x28, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4007fc <.text+0x4bc>
               	jmp	0x400782 <.text+0x442>
               	movq	0x98(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x7, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4008a7 <.text+0x567>
               	jmp	0x40085e <.text+0x51e>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400801 <.text+0x4c1>
               	movq	0xa8(%rsp), %rax
               	movslq	%eax, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x90(%rsp)
               	jmp	0x4008ac <.text+0x56c>
               	leaq	0xf8fb(%rip), %r12      # 0x410160
               	movl	$0xb, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf94f(%rip), %r12      # 0x4101d6
               	movl	$0x2a, %ebx
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4008a7 <.text+0x567>
               	jmp	0x40082d <.text+0x4ed>
               	movq	0x90(%rsp), %rax
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400955 <.text+0x615>
               	jmp	0x40090c <.text+0x5cc>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4008ac <.text+0x56c>
               	movl	$0xf4240, %eax          # imm = 0xF4240
               	movl	$0xbb8, %r14d           # imm = 0xBB8
               	movslq	%eax, %rax
               	movslq	%r14d, %r14
               	imulq	%r14, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x88(%rsp)
               	jmp	0x40095a <.text+0x61a>
               	leaq	0xf84d(%rip), %r12      # 0x410160
               	movl	$0xc, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf8b8(%rip), %r12      # 0x4101ec
               	movl	$0x30, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400955 <.text+0x615>
               	jmp	0x4008d7 <.text+0x597>
               	movq	0x88(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x4d2fa200, %rax      # imm = 0xB2D05E00
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4009e4 <.text+0x6a4>
               	jmp	0x40099b <.text+0x65b>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40095a <.text+0x61a>
               	jmp	0x4009e9 <.text+0x6a9>
               	leaq	0xf7be(%rip), %r12      # 0x410160
               	movl	$0x14, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf83e(%rip), %r12      # 0x410202
               	movl	$0x3a, %ebx
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4009e4 <.text+0x6a4>
               	jmp	0x400986 <.text+0x646>
               	movq	0x88(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x4d2fa200, %rax      # imm = 0xB2D05E00
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400a9f <.text+0x75f>
               	jmp	0x400a56 <.text+0x716>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4009e9 <.text+0x6a9>
               	movl	$0x10000, %eax          # imm = 0x10000
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	imulq	%rax, %r15
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r15, %r10
               	movq	%r10, 0x80(%rsp)
               	jmp	0x400aa4 <.text+0x764>
               	leaq	0xf703(%rip), %rbx      # 0x410160
               	movl	$0x15, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf79a(%rip), %rbx      # 0x410218
               	movl	$0x3b, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400a9f <.text+0x75f>
               	jmp	0x400a15 <.text+0x6d5>
               	movq	0x80(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400b33 <.text+0x7f3>
               	jmp	0x400aeb <.text+0x7ab>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400aa4 <.text+0x764>
               	jmp	0x400b38 <.text+0x7f8>
               	leaq	0xf66e(%rip), %rbx      # 0x410160
               	movl	$0x16, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf71c(%rip), %rbx      # 0x41022e
               	movl	$0x40, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400b33 <.text+0x7f3>
               	jmp	0x400ad6 <.text+0x796>
               	movq	0x80(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400be2 <.text+0x8a2>
               	jmp	0x400b99 <.text+0x859>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400b38 <.text+0x7f8>
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movq	%rax, %r10
               	shrq	$0x1, %r10
               	movq	%r10, 0x78(%rsp)
               	jmp	0x400be7 <.text+0x8a7>
               	leaq	0xf5c0(%rip), %r15      # 0x410160
               	movl	$0x17, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf683(%rip), %r15      # 0x410244
               	movl	$0x41, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400be2 <.text+0x8a2>
               	jmp	0x400b6a <.text+0x82a>
               	movq	0x78(%rsp), %rax
               	cmpq	$0x40000000, %rax       # imm = 0x40000000
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400c8b <.text+0x94b>
               	jmp	0x400c42 <.text+0x902>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400be7 <.text+0x8a7>
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x4, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x70(%rsp)
               	jmp	0x400c90 <.text+0x950>
               	leaq	0xf517(%rip), %r15      # 0x410160
               	movl	$0x1e, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf5f0(%rip), %r15      # 0x41025a
               	movl	$0x4a, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400c8b <.text+0x94b>
               	jmp	0x400c0d <.text+0x8cd>
               	movq	0x70(%rsp), %rax
               	cmpq	$0x23456780, %rax       # imm = 0x23456780
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400d35 <.text+0x9f5>
               	jmp	0x400cec <.text+0x9ac>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400c90 <.text+0x950>
               	xorq	%rax, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	xorq	$-0x1, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	0x400d3a <.text+0x9fa>
               	leaq	0xf46d(%rip), %r15      # 0x410160
               	movl	$0x1f, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf55c(%rip), %r15      # 0x410270
               	movl	$0x4f, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400d35 <.text+0x9f5>
               	jmp	0x400cb6 <.text+0x976>
               	movq	0x68(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400ddc <.text+0xa9c>
               	jmp	0x400d93 <.text+0xa53>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400d3a <.text+0x9fa>
               	leaq	0xf523(%rip), %r12      # 0x41029c
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x401493 <atoi>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	0x400de1 <.text+0xaa1>
               	leaq	0xf3c6(%rip), %r15      # 0x410160
               	movl	$0x20, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf4cb(%rip), %r15      # 0x410286
               	movl	$0x54, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400ddc <.text+0xa9c>
               	jmp	0x400d62 <.text+0xa22>
               	movq	0x60(%rsp), %r12
               	movslq	%r12d, %r12
               	cmpq	$-0x7fffffff, %r12      # imm = 0x80000001
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400e67 <.text+0xb27>
               	jmp	0x400e1f <.text+0xadf>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400de1 <.text+0xaa1>
               	jmp	0x400e6c <.text+0xb2c>
               	leaq	0xf33a(%rip), %r15      # 0x410160
               	movl	$0x28, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf461(%rip), %r15      # 0x4102a8
               	movl	$0x5d, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400e67 <.text+0xb27>
               	jmp	0x400e0a <.text+0xaca>
               	movq	0x60(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x7fffffff, %rax      # imm = 0x80000001
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400f34 <.text+0xbf4>
               	jmp	0x400eeb <.text+0xbab>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400e6c <.text+0xb2c>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x58(%rsp)
               	movq	0x48(%rsp), %rbx
               	movslq	%ebx, %rbx
               	movq	0x58(%rsp), %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	addq	%r12, %rbx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	0x400f39 <.text+0xbf9>
               	leaq	0xf26e(%rip), %rbx      # 0x410160
               	movl	$0x29, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf3ab(%rip), %rbx      # 0x4102be
               	movl	$0x5e, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400f34 <.text+0xbf4>
               	jmp	0x400e95 <.text+0xb55>
               	movq	0x50(%rsp), %r12
               	cmpq	$0x0, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400fe4 <.text+0xca4>
               	jmp	0x400f9b <.text+0xc5b>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400f39 <.text+0xbf9>
               	movq	0x48(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x58(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	subq	%r14, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	0x400fe9 <.text+0xca9>
               	leaq	0xf1be(%rip), %rax      # 0x410160
               	movl	$0x32, %r12d
               	movl	%r12d, (%rax)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf311(%rip), %r15      # 0x4102d4
               	movl	$0x68, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400fe4 <.text+0xca4>
               	jmp	0x400f5f <.text+0xc1f>
               	movq	0x40(%rsp), %rax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x40107a <.text+0xd3a>
               	jmp	0x401031 <.text+0xcf1>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400fe9 <.text+0xca9>
               	movl	$0x12345678, %r10d      # imm = 0x12345678
               	movq	%r10, 0x38(%rsp)
               	jmp	0x40107f <.text+0xd3f>
               	leaq	0xf128(%rip), %r15      # 0x410160
               	movl	$0x33, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf291(%rip), %r15      # 0x4102ea
               	movl	$0x6c, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40107a <.text+0xd3a>
               	jmp	0x401011 <.text+0xcd1>
               	movq	0x38(%rsp), %r12
               	movslq	%r12d, %r12
               	cmpq	$0x12345678, %r12       # imm = 0x12345678
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401112 <.text+0xdd2>
               	jmp	0x4010ca <.text+0xd8a>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40107f <.text+0xd3f>
               	movq	0x38(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	0x401117 <.text+0xdd7>
               	leaq	0xf08f(%rip), %r15      # 0x410160
               	movl	$0x3c, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf20f(%rip), %r15      # 0x410300
               	movl	$0x73, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x401112 <.text+0xdd2>
               	jmp	0x4010a8 <.text+0xd68>
               	movq	0x30(%rsp), %r14
               	cmpq	$0x12345678, %r14       # imm = 0x12345678
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4011b6 <.text+0xe76>
               	jmp	0x40116e <.text+0xe2e>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401117 <.text+0xdd7>
               	movabsq	$-0x77359400, %r10      # imm = 0x88CA6C00
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x20(%rsp)
               	jmp	0x4011bb <.text+0xe7b>
               	leaq	0xefeb(%rip), %r15      # 0x410160
               	movl	$0x3d, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf180(%rip), %r15      # 0x410316
               	movl	$0x75, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4011b6 <.text+0xe76>
               	jmp	0x40113d <.text+0xdfd>
               	movq	0x20(%rsp), %r15
               	cmpq	$-0x77359400, %r15      # imm = 0x88CA6C00
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40123e <.text+0xefe>
               	jmp	0x4011f6 <.text+0xeb6>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4011bb <.text+0xe7b>
               	jmp	0x401243 <.text+0xf03>
               	leaq	0xef63(%rip), %rbx      # 0x410160
               	movl	$0x3e, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf10f(%rip), %rbx      # 0x41032c
               	movl	$0x7a, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40123e <.text+0xefe>
               	jmp	0x4011e1 <.text+0xea1>
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	cmpq	$-0x77359400, %rax      # imm = 0x88CA6C00
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4012e1 <.text+0xfa1>
               	jmp	0x401298 <.text+0xf58>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401243 <.text+0xf03>
               	leaq	0xeedd(%rip), %rax      # 0x410160
               	movslq	(%rax), %r12
               	cmpq	$0x0, %r12
               	jne	0x40131f <.text+0xfdf>
               	jmp	0x4012e6 <.text+0xfa6>
               	leaq	0xeec1(%rip), %r14      # 0x410160
               	movl	$0x3f, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf082(%rip), %r14      # 0x410342
               	movl	$0x7b, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40148d <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4012e1 <.text+0xfa1>
               	jmp	0x40126c <.text+0xf2c>
               	leaq	0xf06b(%rip), %r15      # 0x410358
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x401499 <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	0xee3a(%rip), %r15      # 0x410160
               	movslq	(%r15), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
