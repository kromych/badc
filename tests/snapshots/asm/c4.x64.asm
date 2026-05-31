
c4.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x404a1a <.text+0x45ba>
               	movq	%rax, %rdi
               	callq	*0xfc81(%rip)           # 0x4100f8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfc9e(%rip), %r9       # 0x410138
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x4004e5 <.text+0x85>
               	leaq	0xfc7d(%rip), %r9       # 0x410138
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
               	leaq	0xfc5d(%rip), %rdi      # 0x410150
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfc4e(%rip), %rdi      # 0x410156
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfc40(%rip), %rdi      # 0x41015d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x406d27 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400567 <.text+0x107>
               	leaq	0xfbe6(%rip), %r14      # 0x410138
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400567 <.text+0x107>
               	leaq	0xfbca(%rip), %r12      # 0x410138
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
               	subq	$0x170, %rsp            # imm = 0x170
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	jmp	0x4005b9 <.text+0x159>
               	leaq	0xfc00(%rip), %r11      # 0x4101c0
               	leaq	0xfbc1(%rip), %r9       # 0x410188
               	movq	(%r9), %r8
               	movzbq	(%r8), %r9
               	movq	%r9, (%r11)
               	cmpq	$0x0, %r9
               	je	0x40060e <.text+0x1ae>
               	leaq	0xfba3(%rip), %r8       # 0x410188
               	movq	(%r8), %r9
               	addq	$0x1, %r9
               	movq	%r9, (%r8)
               	leaq	0xfbc7(%rip), %r11      # 0x4101c0
               	movq	(%r11), %r9
               	cmpq	$0xa, %r9
               	jne	0x400654 <.text+0x1f4>
               	jmp	0x400633 <.text+0x1d3>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xfbae(%rip), %r11      # 0x4101e8
               	movq	(%r11), %r9
               	cmpq	$0x0, %r9
               	je	0x4006e2 <.text+0x282>
               	jmp	0x400670 <.text+0x210>
               	jmp	0x4005b9 <.text+0x159>
               	leaq	0xfb65(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x23, %r12
               	jne	0x4007d3 <.text+0x373>
               	jmp	0x4007c9 <.text+0x369>
               	leaq	0xfb81(%rip), %rbx      # 0x4101f8
               	leaq	0xfb62(%rip), %r9       # 0x4101e0
               	movq	(%r9), %r12
               	leaq	0xfb00(%rip), %r10      # 0x410188
               	movq	%r10, 0x20(%rsp)
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rdi
               	leaq	0xfaf4(%rip), %r10      # 0x410190
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %rdx
               	movq	%rdi, %r15
               	subq	%rdx, %r15
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x28(%rsp), %r11
               	movq	%rax, (%r11)
               	jmp	0x4006fb <.text+0x29b>
               	leaq	0xfaf7(%rip), %r14      # 0x4101e0
               	movq	(%r14), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%r14)
               	jmp	0x40064f <.text+0x1ef>
               	leaq	0xfaa6(%rip), %rax      # 0x4101a8
               	movq	(%rax), %r14
               	leaq	0xfa94(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	cmpq	%r15, %r14
               	jge	0x400773 <.text+0x313>
               	leaq	0xfae2(%rip), %rbx      # 0x410201
               	leaq	0xfae1(%rip), %r14      # 0x410207
               	leaq	0xfa7b(%rip), %r15      # 0x4101a8
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movq	(%r12), %rax
               	movl	$0x5, %r11d
               	imulq	%r11, %rax
               	addq	%rax, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movq	(%r15), %rax
               	movq	(%rax), %r15
               	cmpq	$0x7, %r15
               	jg	0x4007b0 <.text+0x350>
               	jmp	0x400778 <.text+0x318>
               	jmp	0x4006e2 <.text+0x282>
               	leaq	0xfb4c(%rip), %r12      # 0x4102cb
               	leaq	0xfa22(%rip), %r15      # 0x4101a8
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	jmp	0x4007ab <.text+0x34b>
               	jmp	0x4006fb <.text+0x29b>
               	leaq	0xfb19(%rip), %r14      # 0x4102d0
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	jmp	0x4007ab <.text+0x34b>
               	jmp	0x400803 <.text+0x3a3>
               	jmp	0x40064f <.text+0x1ef>
               	leaq	0xf9e6(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x61, %r14
               	setge	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x48(%rbp)
               	cmpq	$0x0, %r14
               	je	0x4008ce <.text+0x46e>
               	jmp	0x4008ab <.text+0x44b>
               	leaq	0xf97e(%rip), %rax      # 0x410188
               	movq	(%rax), %r12
               	movzbq	(%r12), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x30(%rbp)
               	cmpq	$0x0, %rax
               	je	0x400895 <.text+0x435>
               	jmp	0x40085e <.text+0x3fe>
               	leaq	0xf941(%rip), %rax      # 0x410188
               	movq	(%rax), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rax)
               	jmp	0x400803 <.text+0x3a3>
               	jmp	0x4007ce <.text+0x36e>
               	leaq	0xf923(%rip), %r12      # 0x410188
               	movq	(%r12), %rax
               	movzbq	(%rax), %r12
               	xorq	$0xa, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x30(%rbp)
               	jmp	0x400895 <.text+0x435>
               	movq	-0x30(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400859 <.text+0x3f9>
               	jmp	0x400840 <.text+0x3e0>
               	leaq	0xf90e(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x7a, %r14
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x4008ce <.text+0x46e>
               	movq	-0x48(%rbp), %r14
               	movq	%r14, -0x40(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400913 <.text+0x4b3>
               	leaq	0xf8d6(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x41, %r14
               	setge	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x50(%rbp)
               	cmpq	$0x0, %r14
               	je	0x400950 <.text+0x4f0>
               	jmp	0x40092d <.text+0x4cd>
               	movq	-0x40(%rbp), %r14
               	movq	%r14, -0x38(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400980 <.text+0x520>
               	jmp	0x40095d <.text+0x4fd>
               	leaq	0xf88c(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x5a, %r14
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x50(%rbp)
               	jmp	0x400950 <.text+0x4f0>
               	movq	-0x50(%rbp), %r14
               	movq	%r14, -0x40(%rbp)
               	jmp	0x400913 <.text+0x4b3>
               	leaq	0xf85c(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x5f, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x38(%rbp)
               	jmp	0x400980 <.text+0x520>
               	movq	-0x38(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4009ad <.text+0x54d>
               	leaq	0xf7f0(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	subq	$0x1, %r14
               	jmp	0x4009df <.text+0x57f>
               	jmp	0x4007ce <.text+0x36e>
               	leaq	0xf80c(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rax
               	cmpq	$0x30, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x90(%rbp)
               	cmpq	$0x0, %rax
               	je	0x400db4 <.text+0x954>
               	jmp	0x400d8f <.text+0x92f>
               	leaq	0xf7a2(%rip), %r12      # 0x410188
               	movq	(%r12), %rax
               	movzbq	(%rax), %r12
               	cmpq	$0x61, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x70(%rbp)
               	cmpq	$0x0, %r12
               	je	0x400ab0 <.text+0x650>
               	jmp	0x400a89 <.text+0x629>
               	leaq	0xf7a6(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	movl	$0x93, %r11d
               	imulq	%r11, %r12
               	leaq	0xf75a(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r15
               	movq	%r15, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rbx)
               	movzbq	(%r15), %rcx
               	addq	%rcx, %r12
               	movq	%r12, (%rax)
               	jmp	0x4009df <.text+0x57f>
               	leaq	0xf76c(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rcx
               	shlq	$0x6, %rcx
               	leaq	0xf725(%rip), %rax      # 0x410188
               	movq	(%rax), %r15
               	subq	%r14, %r15
               	addq	%r15, %rcx
               	movq	%rcx, (%r12)
               	leaq	0xf739(%rip), %r15      # 0x4101b0
               	leaq	0xf73a(%rip), %rcx      # 0x4101b8
               	movq	(%rcx), %r12
               	movq	%r12, (%r15)
               	jmp	0x400c16 <.text+0x7b6>
               	leaq	0xf6f8(%rip), %rax      # 0x410188
               	movq	(%rax), %r12
               	movzbq	(%r12), %rax
               	cmpq	$0x7a, %rax
               	setle	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x70(%rbp)
               	jmp	0x400ab0 <.text+0x650>
               	movq	-0x70(%rbp), %rax
               	movq	%rax, -0x68(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400af9 <.text+0x699>
               	leaq	0xf6bc(%rip), %r12      # 0x410188
               	movq	(%r12), %rax
               	movzbq	(%rax), %r12
               	cmpq	$0x41, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x78(%rbp)
               	cmpq	$0x0, %r12
               	je	0x400b3a <.text+0x6da>
               	jmp	0x400b13 <.text+0x6b3>
               	movq	-0x68(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400b7b <.text+0x71b>
               	jmp	0x400b47 <.text+0x6e7>
               	leaq	0xf66e(%rip), %rax      # 0x410188
               	movq	(%rax), %r12
               	movzbq	(%r12), %rax
               	cmpq	$0x5a, %rax
               	setle	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x78(%rbp)
               	jmp	0x400b3a <.text+0x6da>
               	movq	-0x78(%rbp), %rax
               	movq	%rax, -0x68(%rbp)
               	jmp	0x400af9 <.text+0x699>
               	leaq	0xf63a(%rip), %r12      # 0x410188
               	movq	(%r12), %rax
               	movzbq	(%rax), %r12
               	cmpq	$0x30, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x80(%rbp)
               	cmpq	$0x0, %r12
               	je	0x400bbc <.text+0x75c>
               	jmp	0x400b95 <.text+0x735>
               	movq	-0x60(%rbp), %rax
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400c00 <.text+0x7a0>
               	jmp	0x400bc9 <.text+0x769>
               	leaq	0xf5ec(%rip), %rax      # 0x410188
               	movq	(%rax), %r12
               	movzbq	(%r12), %rax
               	cmpq	$0x39, %rax
               	setle	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x80(%rbp)
               	jmp	0x400bbc <.text+0x75c>
               	movq	-0x80(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	jmp	0x400b7b <.text+0x71b>
               	leaq	0xf5b8(%rip), %r12      # 0x410188
               	movq	(%r12), %rax
               	movzbq	(%rax), %r12
               	xorq	$0x5f, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x58(%rbp)
               	jmp	0x400c00 <.text+0x7a0>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400a4d <.text+0x5ed>
               	jmp	0x400a13 <.text+0x5b3>
               	leaq	0xf593(%rip), %r12      # 0x4101b0
               	movq	(%r12), %rcx
               	movq	(%rcx), %r12
               	cmpq	$0x0, %r12
               	je	0x400c73 <.text+0x813>
               	leaq	0xf588(%rip), %rcx      # 0x4101c0
               	movq	(%rcx), %r12
               	leaq	0xf56e(%rip), %rcx      # 0x4101b0
               	movq	(%rcx), %r15
               	addq	$0x8, %r15
               	movq	(%r15), %rcx
               	cmpq	%rcx, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x88(%rbp)
               	cmpq	$0x0, %r12
               	je	0x400d26 <.text+0x8c6>
               	jmp	0x400cd5 <.text+0x875>
               	leaq	0xf536(%rip), %rax      # 0x4101b0
               	movq	(%rax), %r12
               	addq	$0x10, %r12
               	movq	%r14, (%r12)
               	movq	(%rax), %rbx
               	addq	$0x8, %rbx
               	leaq	0xf527(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	movq	%r14, (%rbx)
               	movq	(%rax), %r15
               	xorq	%rax, %rax
               	movl	$0x85, %r14d
               	movq	%r14, (%r15)
               	movq	%r14, (%r12)
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xf4d4(%rip), %rcx      # 0x4101b0
               	movq	(%rcx), %r12
               	addq	$0x10, %r12
               	movq	(%r12), %rbx
               	leaq	0xf497(%rip), %r12      # 0x410188
               	movq	(%r12), %r15
               	subq	%r14, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x406d33 <memcmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x88(%rbp)
               	jmp	0x400d26 <.text+0x8c6>
               	movq	-0x88(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400d76 <.text+0x916>
               	leaq	0xf47f(%rip), %r15      # 0x4101c0
               	leaq	0xf468(%rip), %rax      # 0x4101b0
               	movq	(%rax), %rbx
               	xorq	%rax, %rax
               	movq	(%rbx), %r12
               	movq	%r12, (%r15)
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xf433(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %rax
               	addq	$0x48, %rax
               	movq	%rax, (%rbx)
               	jmp	0x400c16 <.text+0x7b6>
               	leaq	0xf42a(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rax
               	cmpq	$0x39, %rax
               	setle	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x90(%rbp)
               	jmp	0x400db4 <.text+0x954>
               	movq	-0x90(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400dfa <.text+0x99a>
               	leaq	0xf3f9(%rip), %rbx      # 0x4101c8
               	leaq	0xf3ea(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	subq	$0x30, %r14
               	movq	%r14, (%rbx)
               	cmpq	$0x0, %r14
               	je	0x400e4f <.text+0x9ef>
               	jmp	0x400e16 <.text+0x9b6>
               	jmp	0x4009a8 <.text+0x548>
               	leaq	0xf3bf(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r12
               	cmpq	$0x2f, %r12
               	jne	0x4012de <.text+0xe7e>
               	jmp	0x4012a8 <.text+0xe48>
               	jmp	0x400e95 <.text+0xa35>
               	leaq	0xf39e(%rip), %r14      # 0x4101c0
               	movl	$0x80, %ebx
               	movq	%rbx, (%r14)
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xf332(%rip), %r14      # 0x410188
               	movq	(%r14), %rdi
               	movzbq	(%rdi), %r14
               	xorq	$0x78, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xa0(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400f8d <.text+0xb2d>
               	jmp	0x400f54 <.text+0xaf4>
               	leaq	0xf2ec(%rip), %rax      # 0x410188
               	movq	(%rax), %r14
               	movzbq	(%r14), %rax
               	cmpq	$0x30, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x98(%rbp)
               	cmpq	$0x0, %rax
               	je	0x400f3b <.text+0xadb>
               	jmp	0x400f12 <.text+0xab2>
               	leaq	0xf2f6(%rip), %rax      # 0x4101c8
               	movq	(%rax), %r14
               	movl	$0xa, %r11d
               	imulq	%r11, %r14
               	leaq	0xf2a2(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r12
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rbx)
               	movzbq	(%r12), %rdi
               	addq	%rdi, %r14
               	subq	$0x30, %r14
               	movq	%r14, (%rax)
               	jmp	0x400e95 <.text+0xa35>
               	jmp	0x400e1b <.text+0x9bb>
               	leaq	0xf26f(%rip), %r14      # 0x410188
               	movq	(%r14), %rax
               	movzbq	(%rax), %r14
               	cmpq	$0x39, %r14
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x98(%rbp)
               	jmp	0x400f3b <.text+0xadb>
               	movq	-0x98(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x400f0d <.text+0xaad>
               	jmp	0x400ecb <.text+0xa6b>
               	leaq	0xf22d(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r14
               	movzbq	(%r14), %rdi
               	xorq	$0x58, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rdi
               	cmpq	$0x0, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0xa0(%rbp)
               	jmp	0x400f8d <.text+0xb2d>
               	movq	-0xa0(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	0x400fab <.text+0xb4b>
               	jmp	0x400fb0 <.text+0xb50>
               	jmp	0x400e1b <.text+0x9bb>
               	jmp	0x4011ec <.text+0xd8c>
               	leaq	0xf209(%rip), %r14      # 0x4101c0
               	leaq	0xf1ca(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rdi)
               	movzbq	(%rax), %r12
               	movq	%r12, (%r14)
               	movq	%r12, -0xa8(%rbp)
               	cmpq	$0x0, %r12
               	je	0x401059 <.text+0xbf9>
               	jmp	0x401027 <.text+0xbc7>
               	leaq	0xf1d6(%rip), %rax      # 0x4101c8
               	movq	(%rax), %r12
               	shlq	$0x4, %r12
               	leaq	0xf1c0(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rdi
               	andq	$0xf, %rdi
               	addq	%rdi, %r12
               	movq	(%r14), %rdi
               	cmpq	$0x41, %rdi
               	jl	0x4011cb <.text+0xd6b>
               	jmp	0x4011b9 <.text+0xd59>
               	jmp	0x400fa6 <.text+0xb46>
               	leaq	0xf192(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x30, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xc0(%rbp)
               	cmpq	$0x0, %r12
               	je	0x401097 <.text+0xc37>
               	jmp	0x401072 <.text+0xc12>
               	movq	-0xa8(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x401022 <.text+0xbc2>
               	jmp	0x400feb <.text+0xb8b>
               	leaq	0xf147(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x39, %r12
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xc0(%rbp)
               	jmp	0x401097 <.text+0xc37>
               	movq	-0xc0(%rbp), %r12
               	movq	%r12, -0xb8(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x4010e4 <.text+0xc84>
               	leaq	0xf107(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x61, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xc8(%rbp)
               	cmpq	$0x0, %r12
               	je	0x401129 <.text+0xcc9>
               	jmp	0x401104 <.text+0xca4>
               	movq	-0xb8(%rbp), %r12
               	movq	%r12, -0xb0(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x40116e <.text+0xd0e>
               	jmp	0x40113c <.text+0xcdc>
               	leaq	0xf0b5(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x66, %r12
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xc8(%rbp)
               	jmp	0x401129 <.text+0xcc9>
               	movq	-0xc8(%rbp), %r12
               	movq	%r12, -0xb8(%rbp)
               	jmp	0x4010e4 <.text+0xc84>
               	leaq	0xf07d(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x41, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xd0(%rbp)
               	cmpq	$0x0, %r12
               	je	0x4011a6 <.text+0xd46>
               	jmp	0x401181 <.text+0xd21>
               	movq	-0xb0(%rbp), %r12
               	movq	%r12, -0xa8(%rbp)
               	jmp	0x401059 <.text+0xbf9>
               	leaq	0xf038(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x46, %r12
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xd0(%rbp)
               	jmp	0x4011a6 <.text+0xd46>
               	movq	-0xd0(%rbp), %r12
               	movq	%r12, -0xb0(%rbp)
               	jmp	0x40116e <.text+0xd0e>
               	movl	$0x9, %r14d
               	movq	%r14, -0xd8(%rbp)
               	jmp	0x4011da <.text+0xd7a>
               	xorq	%r14, %r14
               	movq	%r14, -0xd8(%rbp)
               	jmp	0x4011da <.text+0xd7a>
               	movq	-0xd8(%rbp), %r14
               	addq	%r14, %r12
               	movq	%r12, (%rax)
               	jmp	0x400fb0 <.text+0xb50>
               	leaq	0xef95(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	movzbq	(%r14), %r12
               	cmpq	$0x30, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xe0(%rbp)
               	cmpq	$0x0, %r12
               	je	0x40128f <.text+0xe2f>
               	jmp	0x401265 <.text+0xe05>
               	leaq	0xef9e(%rip), %r12      # 0x4101c8
               	movq	(%r12), %r14
               	shlq	$0x3, %r14
               	leaq	0xef4f(%rip), %rax      # 0x410188
               	movq	(%rax), %rdi
               	movq	%rdi, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rax)
               	movzbq	(%rdi), %rbx
               	addq	%rbx, %r14
               	subq	$0x30, %r14
               	movq	%r14, (%r12)
               	jmp	0x4011ec <.text+0xd8c>
               	jmp	0x400fa6 <.text+0xb46>
               	leaq	0xef1c(%rip), %r14      # 0x410188
               	movq	(%r14), %r12
               	movzbq	(%r12), %r14
               	cmpq	$0x37, %r14
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xe0(%rbp)
               	jmp	0x40128f <.text+0xe2f>
               	movq	-0xe0(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x401260 <.text+0xe00>
               	jmp	0x401223 <.text+0xdc3>
               	leaq	0xeed9(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r12
               	movzbq	(%r12), %rbx
               	xorq	$0x2f, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401331 <.text+0xed1>
               	jmp	0x401311 <.text+0xeb1>
               	jmp	0x400df5 <.text+0x995>
               	leaq	0xeedb(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rbx
               	cmpq	$0x27, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xf0(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x40143b <.text+0xfdb>
               	jmp	0x401415 <.text+0xfb5>
               	leaq	0xee70(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r12)
               	jmp	0x401366 <.text+0xf06>
               	jmp	0x4012d9 <.text+0xe79>
               	leaq	0xee88(%rip), %r14      # 0x4101c0
               	movl	$0xa0, %r12d
               	movq	%r12, (%r14)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xee1b(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r14
               	movzbq	(%r14), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xe8(%rbp)
               	cmpq	$0x0, %rbx
               	je	0x4013fc <.text+0xf9c>
               	jmp	0x4013c3 <.text+0xf63>
               	leaq	0xeddc(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rbx)
               	jmp	0x401366 <.text+0xf06>
               	jmp	0x40132c <.text+0xecc>
               	leaq	0xedbe(%rip), %r14      # 0x410188
               	movq	(%r14), %rbx
               	movzbq	(%rbx), %r14
               	xorq	$0xa, %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	$0x0, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xe8(%rbp)
               	jmp	0x4013fc <.text+0xf9c>
               	movq	-0xe8(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4013be <.text+0xf5e>
               	jmp	0x4013a5 <.text+0xf45>
               	leaq	0xeda4(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rbx
               	cmpq	$0x22, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xf0(%rbp)
               	jmp	0x40143b <.text+0xfdb>
               	movq	-0xf0(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x401464 <.text+0x1004>
               	leaq	0xed42(%rip), %r12      # 0x410198
               	movq	(%r12), %rbx
               	jmp	0x401480 <.text+0x1020>
               	jmp	0x4012d9 <.text+0xe79>
               	leaq	0xed55(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x3d, %r15
               	jne	0x401690 <.text+0x1230>
               	jmp	0x40165b <.text+0x11fb>
               	leaq	0xed01(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	movzbq	(%r14), %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf8(%rbp)
               	cmpq	$0x0, %r12
               	je	0x40155a <.text+0x10fa>
               	jmp	0x401529 <.text+0x10c9>
               	leaq	0xed01(%rip), %rdi      # 0x4101c8
               	leaq	0xecba(%rip), %r14      # 0x410188
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%r14)
               	movzbq	(%r12), %rax
               	movq	%rax, (%rdi)
               	cmpq	$0x5c, %rax
               	jne	0x4015ab <.text+0x114b>
               	jmp	0x401573 <.text+0x1113>
               	leaq	0xec89(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rdi)
               	leaq	0xecad(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x22, %r15
               	jne	0x401645 <.text+0x11e5>
               	jmp	0x401610 <.text+0x11b0>
               	leaq	0xec58(%rip), %r14      # 0x410188
               	movq	(%r14), %r12
               	movzbq	(%r12), %r14
               	leaq	0xec81(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rdi
               	cmpq	%rdi, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xf8(%rbp)
               	jmp	0x40155a <.text+0x10fa>
               	movq	-0xf8(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4014f8 <.text+0x1098>
               	jmp	0x4014c0 <.text+0x1060>
               	leaq	0xec4e(%rip), %r12      # 0x4101c8
               	leaq	0xec07(%rip), %rax      # 0x410188
               	movq	(%rax), %rdi
               	movq	%rdi, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rax)
               	movzbq	(%rdi), %r14
               	movq	%r14, (%r12)
               	cmpq	$0x6e, %r14
               	jne	0x4015dc <.text+0x117c>
               	jmp	0x4015c7 <.text+0x1167>
               	leaq	0xec0e(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x22, %r12
               	jne	0x40160b <.text+0x11ab>
               	jmp	0x4015e1 <.text+0x1181>
               	leaq	0xebfa(%rip), %rdi      # 0x4101c8
               	movl	$0xa, %r14d
               	movq	%r14, (%rdi)
               	jmp	0x4015dc <.text+0x117c>
               	jmp	0x4015ab <.text+0x114b>
               	leaq	0xebb0(%rip), %r14      # 0x410198
               	movq	(%r14), %r12
               	movq	%r12, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r14)
               	leaq	0xebc9(%rip), %r15      # 0x4101c8
               	movq	(%r15), %rdi
               	movb	%dil, (%r12)
               	jmp	0x40160b <.text+0x11ab>
               	jmp	0x401480 <.text+0x1020>
               	leaq	0xebb1(%rip), %r12      # 0x4101c8
               	movq	%rbx, (%r12)
               	jmp	0x401620 <.text+0x11c0>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xeb74(%rip), %r12      # 0x4101c0
               	movl	$0x80, %r15d
               	movq	%r15, (%r12)
               	jmp	0x401620 <.text+0x11c0>
               	leaq	0xeb26(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r15
               	movzbq	(%r15), %rbx
               	xorq	$0x3d, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4016fb <.text+0x129b>
               	jmp	0x4016ad <.text+0x124d>
               	jmp	0x40145f <.text+0xfff>
               	leaq	0xeb29(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x2b, %r15
               	jne	0x401746 <.text+0x12e6>
               	jmp	0x401710 <.text+0x12b0>
               	leaq	0xead4(%rip), %r15      # 0x410188
               	movq	(%r15), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r15)
               	leaq	0xeaf8(%rip), %r12      # 0x4101c0
               	movl	$0x95, %ebx
               	movq	%rbx, (%r12)
               	jmp	0x4016d6 <.text+0x1276>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xeabe(%rip), %rbx      # 0x4101c0
               	movl	$0x8e, %r15d
               	movq	%r15, (%rbx)
               	jmp	0x4016d6 <.text+0x1276>
               	leaq	0xea71(%rip), %r12      # 0x410188
               	movq	(%r12), %r15
               	movzbq	(%r15), %r12
               	xorq	$0x2b, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	jne	0x4017b0 <.text+0x1350>
               	jmp	0x401762 <.text+0x1302>
               	jmp	0x40168b <.text+0x122b>
               	leaq	0xea73(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x2d, %r15
               	jne	0x4017fb <.text+0x139b>
               	jmp	0x4017c6 <.text+0x1366>
               	leaq	0xea1f(%rip), %r15      # 0x410188
               	movq	(%r15), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%r15)
               	leaq	0xea43(%rip), %rbx      # 0x4101c0
               	movl	$0xa2, %r12d
               	movq	%r12, (%rbx)
               	jmp	0x40178b <.text+0x132b>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xea09(%rip), %r12      # 0x4101c0
               	movl	$0x9d, %r15d
               	movq	%r15, (%r12)
               	jmp	0x40178b <.text+0x132b>
               	leaq	0xe9bb(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r15
               	movzbq	(%r15), %rbx
               	xorq	$0x2d, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401866 <.text+0x1406>
               	jmp	0x401818 <.text+0x13b8>
               	jmp	0x401741 <.text+0x12e1>
               	leaq	0xe9be(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x21, %r15
               	jne	0x4018b1 <.text+0x1451>
               	jmp	0x40187b <.text+0x141b>
               	leaq	0xe969(%rip), %r15      # 0x410188
               	movq	(%r15), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r15)
               	leaq	0xe98d(%rip), %r12      # 0x4101c0
               	movl	$0xa3, %ebx
               	movq	%rbx, (%r12)
               	jmp	0x401841 <.text+0x13e1>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe953(%rip), %rbx      # 0x4101c0
               	movl	$0x9e, %r15d
               	movq	%r15, (%rbx)
               	jmp	0x401841 <.text+0x13e1>
               	leaq	0xe906(%rip), %r12      # 0x410188
               	movq	(%r12), %r15
               	movzbq	(%r15), %r12
               	xorq	$0x3d, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	jne	0x4018f6 <.text+0x1496>
               	jmp	0x4018cd <.text+0x146d>
               	jmp	0x4017f6 <.text+0x1396>
               	leaq	0xe908(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x3c, %r12
               	jne	0x401951 <.text+0x14f1>
               	jmp	0x40191b <.text+0x14bb>
               	leaq	0xe8b4(%rip), %r15      # 0x410188
               	movq	(%r15), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%r15)
               	leaq	0xe8d8(%rip), %rbx      # 0x4101c0
               	movl	$0x96, %r12d
               	movq	%r12, (%rbx)
               	jmp	0x4018f6 <.text+0x1496>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe866(%rip), %r15      # 0x410188
               	movq	(%r15), %r12
               	movzbq	(%r12), %r15
               	xorq	$0x3d, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	jne	0x4019bd <.text+0x155d>
               	jmp	0x40196d <.text+0x150d>
               	jmp	0x4018ac <.text+0x144c>
               	leaq	0xe868(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r12
               	cmpq	$0x3e, %r12
               	jne	0x401a64 <.text+0x1604>
               	jmp	0x401a2e <.text+0x15ce>
               	leaq	0xe814(%rip), %r12      # 0x410188
               	movq	(%r12), %r15
               	addq	$0x1, %r15
               	movq	%r15, (%r12)
               	leaq	0xe836(%rip), %rbx      # 0x4101c0
               	movl	$0x99, %r15d
               	movq	%r15, (%rbx)
               	jmp	0x401998 <.text+0x1538>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe7c4(%rip), %r15      # 0x410188
               	movq	(%r15), %r12
               	movzbq	(%r12), %r15
               	xorq	$0x3c, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	jne	0x401a19 <.text+0x15b9>
               	leaq	0xe798(%rip), %r12      # 0x410188
               	movq	(%r12), %r15
               	addq	$0x1, %r15
               	movq	%r15, (%r12)
               	leaq	0xe7ba(%rip), %rbx      # 0x4101c0
               	movl	$0x9b, %r15d
               	movq	%r15, (%rbx)
               	jmp	0x401a14 <.text+0x15b4>
               	jmp	0x401998 <.text+0x1538>
               	leaq	0xe7a0(%rip), %r15      # 0x4101c0
               	movl	$0x97, %r12d
               	movq	%r12, (%r15)
               	jmp	0x401a14 <.text+0x15b4>
               	leaq	0xe753(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r12
               	movzbq	(%r12), %rbx
               	xorq	$0x3d, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401acf <.text+0x166f>
               	jmp	0x401a80 <.text+0x1620>
               	jmp	0x40194c <.text+0x14ec>
               	leaq	0xe755(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x7c, %r12
               	jne	0x401b75 <.text+0x1715>
               	jmp	0x401b3f <.text+0x16df>
               	leaq	0xe701(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r12)
               	leaq	0xe723(%rip), %r15      # 0x4101c0
               	movl	$0x9a, %ebx
               	movq	%rbx, (%r15)
               	jmp	0x401aaa <.text+0x164a>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe6b2(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r12
               	movzbq	(%r12), %rbx
               	xorq	$0x3e, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401b2a <.text+0x16ca>
               	leaq	0xe686(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r12)
               	leaq	0xe6a8(%rip), %r15      # 0x4101c0
               	movl	$0x9c, %ebx
               	movq	%rbx, (%r15)
               	jmp	0x401b25 <.text+0x16c5>
               	jmp	0x401aaa <.text+0x164a>
               	leaq	0xe68f(%rip), %rbx      # 0x4101c0
               	movl	$0x98, %r12d
               	movq	%r12, (%rbx)
               	jmp	0x401b25 <.text+0x16c5>
               	leaq	0xe642(%rip), %r15      # 0x410188
               	movq	(%r15), %r12
               	movzbq	(%r12), %r15
               	xorq	$0x7c, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	jne	0x401be1 <.text+0x1781>
               	jmp	0x401b91 <.text+0x1731>
               	jmp	0x401a5f <.text+0x15ff>
               	leaq	0xe644(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r12
               	cmpq	$0x26, %r12
               	jne	0x401c2c <.text+0x17cc>
               	jmp	0x401bf6 <.text+0x1796>
               	leaq	0xe5f0(%rip), %r12      # 0x410188
               	movq	(%r12), %r15
               	addq	$0x1, %r15
               	movq	%r15, (%r12)
               	leaq	0xe612(%rip), %rbx      # 0x4101c0
               	movl	$0x90, %r15d
               	movq	%r15, (%rbx)
               	jmp	0x401bbc <.text+0x175c>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe5d8(%rip), %r15      # 0x4101c0
               	movl	$0x92, %r12d
               	movq	%r12, (%r15)
               	jmp	0x401bbc <.text+0x175c>
               	leaq	0xe58b(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r12
               	movzbq	(%r12), %rbx
               	xorq	$0x26, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401c97 <.text+0x1837>
               	jmp	0x401c48 <.text+0x17e8>
               	jmp	0x401b70 <.text+0x1710>
               	leaq	0xe58d(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x5e, %r12
               	jne	0x401ce6 <.text+0x1886>
               	jmp	0x401cac <.text+0x184c>
               	leaq	0xe539(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r12)
               	leaq	0xe55b(%rip), %r15      # 0x4101c0
               	movl	$0x91, %ebx
               	movq	%rbx, (%r15)
               	jmp	0x401c72 <.text+0x1812>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe522(%rip), %rbx      # 0x4101c0
               	movl	$0x94, %r12d
               	movq	%r12, (%rbx)
               	jmp	0x401c72 <.text+0x1812>
               	leaq	0xe50d(%rip), %r15      # 0x4101c0
               	movl	$0x93, %r12d
               	movq	%r12, (%r15)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401c27 <.text+0x17c7>
               	leaq	0xe4d3(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rbx
               	cmpq	$0x25, %rbx
               	jne	0x401d38 <.text+0x18d8>
               	leaq	0xe4bb(%rip), %r12      # 0x4101c0
               	movl	$0xa1, %ebx
               	movq	%rbx, (%r12)
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401ce1 <.text+0x1881>
               	leaq	0xe481(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x2a, %r15
               	jne	0x401d89 <.text+0x1929>
               	leaq	0xe46a(%rip), %rbx      # 0x4101c0
               	movl	$0x9f, %r15d
               	movq	%r15, (%rbx)
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401d33 <.text+0x18d3>
               	leaq	0xe430(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x5b, %r12
               	jne	0x401dda <.text+0x197a>
               	leaq	0xe419(%rip), %r15      # 0x4101c0
               	movl	$0xa4, %r12d
               	movq	%r12, (%r15)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401d84 <.text+0x1924>
               	leaq	0xe3df(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rbx
               	cmpq	$0x3f, %rbx
               	jne	0x401e2c <.text+0x19cc>
               	leaq	0xe3c7(%rip), %r12      # 0x4101c0
               	movl	$0x8f, %ebx
               	movq	%rbx, (%r12)
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401dd5 <.text+0x1975>
               	leaq	0xe38d(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x7e, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x138(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x401e7e <.text+0x1a1e>
               	leaq	0xe360(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x3b, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x138(%rbp)
               	jmp	0x401e7e <.text+0x1a1e>
               	movq	-0x138(%rbp), %r15
               	movq	%r15, -0x130(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x401ebe <.text+0x1a5e>
               	leaq	0xe320(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x7b, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x130(%rbp)
               	jmp	0x401ebe <.text+0x1a5e>
               	movq	-0x130(%rbp), %r15
               	movq	%r15, -0x128(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x401efe <.text+0x1a9e>
               	leaq	0xe2e0(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x7d, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x128(%rbp)
               	jmp	0x401efe <.text+0x1a9e>
               	movq	-0x128(%rbp), %r15
               	movq	%r15, -0x120(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x401f3e <.text+0x1ade>
               	leaq	0xe2a0(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x28, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x120(%rbp)
               	jmp	0x401f3e <.text+0x1ade>
               	movq	-0x120(%rbp), %r15
               	movq	%r15, -0x118(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x401f7e <.text+0x1b1e>
               	leaq	0xe260(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x29, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x118(%rbp)
               	jmp	0x401f7e <.text+0x1b1e>
               	movq	-0x118(%rbp), %r15
               	movq	%r15, -0x110(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x401fbe <.text+0x1b5e>
               	leaq	0xe220(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x5d, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x110(%rbp)
               	jmp	0x401fbe <.text+0x1b5e>
               	movq	-0x110(%rbp), %r15
               	movq	%r15, -0x108(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x401ffe <.text+0x1b9e>
               	leaq	0xe1e0(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x2c, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x108(%rbp)
               	jmp	0x401ffe <.text+0x1b9e>
               	movq	-0x108(%rbp), %r15
               	movq	%r15, -0x100(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x40203e <.text+0x1bde>
               	leaq	0xe1a0(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x3a, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x100(%rbp)
               	jmp	0x40203e <.text+0x1bde>
               	movq	-0x100(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x402077 <.text+0x1c17>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401e27 <.text+0x19c7>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	0xe117(%rip), %r9       # 0x4101c0
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	jne	0x4020fb <.text+0x1c9b>
               	leaq	0xe212(%rip), %r12      # 0x4102d2
               	leaq	0xe119(%rip), %r8       # 0x4101e0
               	movq	(%r8), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4020f6 <.text+0x1c96>
               	jmp	0x4031a4 <.text+0x2d44>
               	leaq	0xe0be(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x80, %rax
               	jne	0x402162 <.text+0x1d02>
               	leaq	0xe087(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1, %r14d
               	movq	%r14, (%rax)
               	movq	(%r15), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r15)
               	leaq	0xe085(%rip), %rax      # 0x4101c8
               	movq	(%rax), %r15
               	movq	%r15, (%rsi)
               	callq	0x400596 <.text+0x136>
               	leaq	0xe07b(%rip), %rax      # 0x4101d0
               	movq	%r14, (%rax)
               	jmp	0x40215d <.text+0x1cfd>
               	jmp	0x4020f6 <.text+0x1c96>
               	leaq	0xe057(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x22, %r15
               	jne	0x4021bf <.text+0x1d5f>
               	leaq	0xe020(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	leaq	0xe01e(%rip), %r14      # 0x4101c8
               	movq	(%r14), %rax
               	movq	%rax, (%rsi)
               	callq	0x400596 <.text+0x136>
               	jmp	0x4021db <.text+0x1d7b>
               	jmp	0x40215d <.text+0x1cfd>
               	leaq	0xdffa(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x8c, %r12
               	jne	0x402253 <.text+0x1df3>
               	jmp	0x40222d <.text+0x1dcd>
               	leaq	0xdfde(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x22, %rax
               	jne	0x4021fc <.text+0x1d9c>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4021db <.text+0x1d7b>
               	leaq	0xdf95(%rip), %r12      # 0x410198
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	andq	$-0x8, %rax
               	movq	%rax, (%r12)
               	leaq	0xdfb0(%rip), %rsi      # 0x4101d0
               	movl	$0x2, %eax
               	movq	%rax, (%rsi)
               	jmp	0x4021ba <.text+0x1d5a>
               	callq	0x400596 <.text+0x136>
               	leaq	0xdf87(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x28, %r12
               	jne	0x4022a5 <.text+0x1e45>
               	jmp	0x402270 <.text+0x1e10>
               	jmp	0x4021ba <.text+0x1d5a>
               	leaq	0xdf66(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x85, %r14
               	jne	0x40246e <.text+0x200e>
               	jmp	0x402439 <.text+0x1fd9>
               	callq	0x400596 <.text+0x136>
               	jmp	0x40227a <.text+0x1e1a>
               	leaq	0xdf4f(%rip), %r15      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r15)
               	leaq	0xdf30(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x8a, %rax
               	jne	0x4022f1 <.text+0x1e91>
               	jmp	0x4022e2 <.text+0x1e82>
               	leaq	0xe048(%rip), %r14      # 0x4102f4
               	leaq	0xdf2d(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x40227a <.text+0x1e1a>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4022ec <.text+0x1e8c>
               	jmp	0x402325 <.text+0x1ec5>
               	leaq	0xdec8(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x86, %rax
               	jne	0x402320 <.text+0x1ec0>
               	callq	0x400596 <.text+0x136>
               	leaq	0xdebb(%rip), %rax      # 0x4101d0
               	xorq	%r14, %r14
               	movq	%r14, (%rax)
               	jmp	0x402320 <.text+0x1ec0>
               	jmp	0x4022ec <.text+0x1e8c>
               	leaq	0xde94(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x9f, %r15
               	jne	0x40235a <.text+0x1efa>
               	callq	0x400596 <.text+0x136>
               	leaq	0xde88(%rip), %rax      # 0x4101d0
               	movq	(%rax), %r15
               	addq	$0x2, %r15
               	movq	%r15, (%rax)
               	jmp	0x402325 <.text+0x1ec5>
               	leaq	0xde5f(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x29, %r14
               	jne	0x4023c2 <.text+0x1f62>
               	callq	0x400596 <.text+0x136>
               	jmp	0x40237b <.text+0x1f1b>
               	leaq	0xde1e(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1, %r12d
               	movq	%r12, (%rax)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	leaq	0xde24(%rip), %r12      # 0x4101d0
               	movq	(%r12), %r15
               	cmpq	$0x0, %r15
               	jne	0x40240e <.text+0x1fae>
               	jmp	0x4023ff <.text+0x1f9f>
               	leaq	0xdf4e(%rip), %r12      # 0x410317
               	leaq	0xde10(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x40237b <.text+0x1f1b>
               	movl	$0x1, %r12d
               	movq	%r12, -0x30(%rbp)
               	jmp	0x40241d <.text+0x1fbd>
               	movl	$0x8, %r12d
               	movq	%r12, -0x30(%rbp)
               	jmp	0x40241d <.text+0x1fbd>
               	movq	-0x30(%rbp), %r12
               	movq	%r12, (%r14)
               	leaq	0xdda5(%rip), %r15      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r15)
               	jmp	0x40224e <.text+0x1dee>
               	leaq	0xdd70(%rip), %r12      # 0x4101b0
               	movq	(%r12), %r14
               	movq	%r14, -0x10(%rbp)
               	callq	0x400596 <.text+0x136>
               	leaq	0xdd6c(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x28, %r14
               	jne	0x4024a0 <.text+0x2040>
               	jmp	0x40248a <.text+0x202a>
               	jmp	0x40224e <.text+0x1dee>
               	leaq	0xdd4b(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x28, %r15
               	jne	0x402894 <.text+0x2434>
               	jmp	0x40285b <.text+0x23fb>
               	callq	0x400596 <.text+0x136>
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	0x4024c1 <.text+0x2061>
               	jmp	0x402469 <.text+0x2009>
               	movq	-0x10(%rbp), %r12
               	addq	$0x18, %r12
               	movq	(%r12), %rax
               	cmpq	$0x80, %rax
               	jne	0x4026ee <.text+0x228e>
               	jmp	0x40269b <.text+0x223b>
               	leaq	0xdcf8(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x29, %r14
               	je	0x402532 <.text+0x20d2>
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xdcb3(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rax)
               	leaq	0xdca4(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x2c, %r15
               	jne	0x402564 <.text+0x2104>
               	jmp	0x402557 <.text+0x20f7>
               	callq	0x400596 <.text+0x136>
               	movq	-0x10(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r14
               	cmpq	$0x82, %r14
               	jne	0x4025a9 <.text+0x2149>
               	jmp	0x402569 <.text+0x2109>
               	callq	0x400596 <.text+0x136>
               	movq	%rax, %r14
               	jmp	0x402564 <.text+0x2104>
               	jmp	0x4024c1 <.text+0x2061>
               	leaq	0xdc30(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movq	-0x10(%rbp), %r15
               	addq	$0x28, %r15
               	movq	(%r15), %rax
               	movq	%rax, (%r14)
               	jmp	0x402593 <.text+0x2133>
               	movq	-0x8(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x40267e <.text+0x221e>
               	jmp	0x402647 <.text+0x21e7>
               	movq	-0x10(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r15
               	cmpq	$0x81, %r15
               	jne	0x40260a <.text+0x21aa>
               	leaq	0xdbd5(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x3, %r14d
               	movq	%r14, (%r15)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movq	-0x10(%rbp), %r14
               	addq	$0x28, %r14
               	movq	(%r14), %rax
               	movq	%rax, (%r12)
               	jmp	0x402605 <.text+0x21a5>
               	jmp	0x402593 <.text+0x2133>
               	leaq	0xdd2a(%rip), %r15      # 0x41033b
               	leaq	0xdbc8(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x402605 <.text+0x21a5>
               	leaq	0xdb52(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x7, %r15d
               	movq	%r15, (%r14)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movq	-0x8(%rbp), %r15
               	movq	%r15, (%r12)
               	jmp	0x40267e <.text+0x221e>
               	leaq	0xdb4b(%rip), %r15      # 0x4101d0
               	movq	-0x10(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %r12
               	movq	%r12, (%r15)
               	jmp	0x40249b <.text+0x203b>
               	leaq	0xdafe(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x1, %r15d
               	movq	%r15, (%rax)
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	-0x10(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	leaq	0xdaef(%rip), %rax      # 0x4101d0
               	movq	%r15, (%rax)
               	jmp	0x4026e9 <.text+0x2289>
               	jmp	0x40249b <.text+0x203b>
               	movq	-0x10(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r12
               	cmpq	$0x84, %r12
               	jne	0x402793 <.text+0x2333>
               	leaq	0xda90(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	xorq	%r15, %r15
               	movq	%r15, (%r12)
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	0xdaa0(%rip), %r15      # 0x4101d8
               	movq	(%r15), %rax
               	movq	-0x10(%rbp), %r15
               	addq	$0x28, %r15
               	movq	(%r15), %r12
               	subq	%r12, %rax
               	movq	%rax, (%r14)
               	jmp	0x402754 <.text+0x22f4>
               	leaq	0xda45(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	leaq	0xda61(%rip), %r12      # 0x4101d0
               	movq	-0x10(%rbp), %r14
               	addq	$0x20, %r14
               	movq	(%r14), %r15
               	movq	%r15, (%r12)
               	cmpq	$0x0, %r15
               	jne	0x402840 <.text+0x23e0>
               	jmp	0x402831 <.text+0x23d1>
               	movq	-0x10(%rbp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r12
               	cmpq	$0x83, %r12
               	jne	0x4027f4 <.text+0x2394>
               	leaq	0xd9eb(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movq	-0x10(%rbp), %r14
               	addq	$0x28, %r14
               	movq	(%r14), %rax
               	movq	%rax, (%r15)
               	jmp	0x4027ef <.text+0x238f>
               	jmp	0x402754 <.text+0x22f4>
               	leaq	0xdb57(%rip), %r12      # 0x410352
               	leaq	0xd9de(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4027ef <.text+0x238f>
               	movl	$0xa, %r14d
               	movq	%r14, -0x38(%rbp)
               	jmp	0x40284f <.text+0x23ef>
               	movl	$0x9, %r14d
               	movq	%r14, -0x38(%rbp)
               	jmp	0x40284f <.text+0x23ef>
               	movq	-0x38(%rbp), %r14
               	movq	%r14, (%rax)
               	jmp	0x4026e9 <.text+0x2289>
               	callq	0x400596 <.text+0x136>
               	leaq	0xd959(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x8a, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x40(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x4028d2 <.text+0x2472>
               	jmp	0x4028b0 <.text+0x2450>
               	jmp	0x402469 <.text+0x2009>
               	leaq	0xd925(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x9f, %rax
               	jne	0x402a89 <.text+0x2629>
               	jmp	0x402a55 <.text+0x25f5>
               	leaq	0xd909(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x86, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x40(%rbp)
               	jmp	0x4028d2 <.text+0x2472>
               	movq	-0x40(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x402904 <.text+0x24a4>
               	leaq	0xd8d6(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x8a, %r15
               	jne	0x40293c <.text+0x24dc>
               	jmp	0x40292e <.text+0x24ce>
               	jmp	0x40288f <.text+0x242f>
               	movl	$0x8e, %r14d
               	movq	%r14, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xd8a7(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x29, %r14
               	jne	0x402a18 <.text+0x25b8>
               	jmp	0x402a09 <.text+0x25a9>
               	movl	$0x1, %eax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x402948 <.text+0x24e8>
               	xorq	%rax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x402948 <.text+0x24e8>
               	movq	-0x48(%rbp), %rax
               	movq	%rax, -0x8(%rbp)
               	callq	0x400596 <.text+0x136>
               	jmp	0x40295a <.text+0x24fa>
               	leaq	0xd85f(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x9f, %rax
               	jne	0x40298a <.text+0x252a>
               	callq	0x400596 <.text+0x136>
               	movq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	0x40295a <.text+0x24fa>
               	leaq	0xd82f(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x29, %r12
               	jne	0x4029cc <.text+0x256c>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4029ab <.text+0x254b>
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xd810(%rip), %rax      # 0x4101d0
               	movq	-0x8(%rbp), %r12
               	movq	%r12, (%rax)
               	jmp	0x4028ff <.text+0x249f>
               	leaq	0xd997(%rip), %r15      # 0x41036a
               	leaq	0xd806(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4029ab <.text+0x254b>
               	callq	0x400596 <.text+0x136>
               	jmp	0x402a13 <.text+0x25b3>
               	jmp	0x4028ff <.text+0x249f>
               	leaq	0xd959(%rip), %r12      # 0x410378
               	leaq	0xd7ba(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x402a13 <.text+0x25b3>
               	callq	0x400596 <.text+0x136>
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xd761(%rip), %rax      # 0x4101d0
               	movq	(%rax), %r15
               	cmpq	$0x1, %r15
               	jle	0x402af0 <.text+0x2690>
               	jmp	0x402aa5 <.text+0x2645>
               	jmp	0x40288f <.text+0x242f>
               	leaq	0xd730(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x94, %r12
               	jne	0x402ba2 <.text+0x2742>
               	jmp	0x402b58 <.text+0x26f8>
               	leaq	0xd724(%rip), %rax      # 0x4101d0
               	movq	(%rax), %r15
               	subq	$0x2, %r15
               	movq	%r15, (%rax)
               	jmp	0x402abe <.text+0x265e>
               	leaq	0xd6db(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	leaq	0xd6f5(%rip), %r14      # 0x4101d0
               	movq	(%r14), %r12
               	cmpq	$0x0, %r12
               	jne	0x402b3d <.text+0x26dd>
               	jmp	0x402b2e <.text+0x26ce>
               	leaq	0xd89b(%rip), %r14      # 0x410392
               	leaq	0xd6e2(%rip), %r12      # 0x4101e0
               	movq	(%r12), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x402abe <.text+0x265e>
               	movl	$0xa, %r14d
               	movq	%r14, -0x50(%rbp)
               	jmp	0x402b4c <.text+0x26ec>
               	movl	$0x9, %r14d
               	movq	%r14, -0x50(%rbp)
               	jmp	0x402b4c <.text+0x26ec>
               	movq	-0x50(%rbp), %r14
               	movq	%r14, (%rax)
               	jmp	0x402a84 <.text+0x2624>
               	callq	0x400596 <.text+0x136>
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xd62e(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	movq	(%r15), %rax
               	cmpq	$0xa, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x402be3 <.text+0x2783>
               	jmp	0x402bbe <.text+0x275e>
               	jmp	0x402a84 <.text+0x2624>
               	leaq	0xd617(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x21, %r12
               	jne	0x402ce7 <.text+0x2887>
               	jmp	0x402c63 <.text+0x2803>
               	leaq	0xd5db(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	movq	(%rax), %r15
               	cmpq	$0x9, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x58(%rbp)
               	jmp	0x402be3 <.text+0x2783>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x402c26 <.text+0x27c6>
               	leaq	0xd5a5(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	addq	$-0x8, %r15
               	movq	%r15, (%rax)
               	jmp	0x402c0d <.text+0x27ad>
               	leaq	0xd5bc(%rip), %r14      # 0x4101d0
               	movq	(%r14), %rax
               	addq	$0x2, %rax
               	movq	%rax, (%r14)
               	jmp	0x402b9d <.text+0x273d>
               	leaq	0xd77a(%rip), %r12      # 0x4103a7
               	leaq	0xd5ac(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x402c0d <.text+0x27ad>
               	callq	0x400596 <.text+0x136>
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xd523(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	xorq	%r12, %r12
               	movq	%r12, (%r15)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0x11, %r12d
               	movq	%r12, (%rdx)
               	leaq	0xd4f6(%rip), %rax      # 0x4101d0
               	movq	%r14, (%rax)
               	jmp	0x402ce2 <.text+0x2882>
               	jmp	0x402b9d <.text+0x273d>
               	leaq	0xd4d2(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x7e, %r12
               	jne	0x402d88 <.text+0x2928>
               	callq	0x400596 <.text+0x136>
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xd488(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%rdx)
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movabsq	$-0x1, %rdx
               	movq	%rdx, (%r15)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xf, %edx
               	movq	%rdx, (%r12)
               	leaq	0xd455(%rip), %rax      # 0x4101d0
               	movq	%r14, (%rax)
               	jmp	0x402d83 <.text+0x2923>
               	jmp	0x402ce2 <.text+0x2882>
               	leaq	0xd431(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rdx
               	cmpq	$0x9d, %rdx
               	jne	0x402dcc <.text+0x296c>
               	callq	0x400596 <.text+0x136>
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xd417(%rip), %rax      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%rax)
               	jmp	0x402dc7 <.text+0x2967>
               	jmp	0x402d83 <.text+0x2923>
               	leaq	0xd3ed(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x9e, %r14
               	jne	0x402e27 <.text+0x29c7>
               	callq	0x400596 <.text+0x136>
               	leaq	0xd3b0(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	leaq	0xd3b3(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x80, %r12
               	jne	0x402ea5 <.text+0x2a45>
               	jmp	0x402e56 <.text+0x29f6>
               	jmp	0x402dc7 <.text+0x2967>
               	leaq	0xd392(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0xa2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x60(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x402f27 <.text+0x2ac7>
               	jmp	0x402f05 <.text+0x2aa5>
               	leaq	0xd343(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	leaq	0xd357(%rip), %r14      # 0x4101c8
               	movq	(%r14), %rax
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	movq	%rax, (%r12)
               	callq	0x400596 <.text+0x136>
               	jmp	0x402e90 <.text+0x2a30>
               	leaq	0xd339(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	jmp	0x402e22 <.text+0x29c2>
               	leaq	0xd2f4(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movabsq	$-0x1, %r12
               	movq	%r12, (%rax)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1b, %r14d
               	movq	%r14, (%rax)
               	jmp	0x402e90 <.text+0x2a30>
               	leaq	0xd2b4(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0xa3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x60(%rbp)
               	jmp	0x402f27 <.text+0x2ac7>
               	movq	-0x60(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x402f7e <.text+0x2b1e>
               	leaq	0xd281(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	movq	%rax, -0x8(%rbp)
               	callq	0x400596 <.text+0x136>
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xd240(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	movq	(%r12), %rax
               	cmpq	$0xa, %rax
               	jne	0x40304e <.text+0x2bee>
               	jmp	0x402fbb <.text+0x2b5b>
               	jmp	0x402e22 <.text+0x29c2>
               	leaq	0xd457(%rip), %r15      # 0x4103dc
               	leaq	0xd254(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x402f79 <.text+0x2b19>
               	leaq	0xd1de(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rax
               	movl	$0xd, %r14d
               	movq	%r14, (%rax)
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xa, %r14d
               	movq	%r14, (%r15)
               	jmp	0x402fec <.text+0x2b8c>
               	leaq	0xd1ad(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%rax)
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	leaq	0xd197(%rip), %r14      # 0x4101d0
               	movq	(%r14), %r12
               	cmpq	$0x2, %r12
               	jle	0x4030ec <.text+0x2c8c>
               	jmp	0x4030dd <.text+0x2c7d>
               	leaq	0xd14b(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	(%r12), %r14
               	cmpq	$0x9, %r14
               	jne	0x40309f <.text+0x2c3f>
               	leaq	0xd130(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x9, %r15d
               	movq	%r15, (%rax)
               	jmp	0x40309a <.text+0x2c3a>
               	jmp	0x402fec <.text+0x2b8c>
               	leaq	0xd315(%rip), %r14      # 0x4103bb
               	leaq	0xd133(%rip), %r12      # 0x4101e0
               	movq	(%r12), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x40309a <.text+0x2c3a>
               	movl	$0x8, %r14d
               	movq	%r14, -0x68(%rbp)
               	jmp	0x4030fb <.text+0x2c9b>
               	movl	$0x1, %r14d
               	movq	%r14, -0x68(%rbp)
               	jmp	0x4030fb <.text+0x2c9b>
               	movq	-0x68(%rbp), %r14
               	movq	%r14, (%rax)
               	leaq	0xd097(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xa2, %rax
               	jne	0x403138 <.text+0x2cd8>
               	movl	$0x19, %r12d
               	movq	%r12, -0x70(%rbp)
               	jmp	0x403147 <.text+0x2ce7>
               	movl	$0x1a, %r12d
               	movq	%r12, -0x70(%rbp)
               	jmp	0x403147 <.text+0x2ce7>
               	movq	-0x70(%rbp), %r12
               	movq	%r12, (%r14)
               	leaq	0xd04b(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	leaq	0xd067(%rip), %r14      # 0x4101d0
               	movq	(%r14), %rax
               	cmpq	$0x0, %rax
               	jne	0x403188 <.text+0x2d28>
               	movl	$0xc, %r14d
               	movq	%r14, -0x78(%rbp)
               	jmp	0x403197 <.text+0x2d37>
               	movl	$0xb, %r14d
               	movq	%r14, -0x78(%rbp)
               	jmp	0x403197 <.text+0x2d37>
               	movq	-0x78(%rbp), %r14
               	movq	%r14, (%r12)
               	jmp	0x402f79 <.text+0x2b19>
               	leaq	0xd015(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	movq	0x28(%rsp), %r10
               	cmpq	%r10, %rax
               	jl	0x4031e9 <.text+0x2d89>
               	leaq	0xd00c(%rip), %r12      # 0x4101d0
               	movq	(%r12), %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	0xcfed(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x8e, %rax
               	jne	0x40324a <.text+0x2dea>
               	jmp	0x40320e <.text+0x2dae>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	callq	0x400596 <.text+0x136>
               	leaq	0xcf86(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movq	(%r14), %rax
               	cmpq	$0xa, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x80(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40328b <.text+0x2e2b>
               	jmp	0x403266 <.text+0x2e06>
               	jmp	0x4031a4 <.text+0x2d44>
               	leaq	0xcf6f(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x8f, %rax
               	jne	0x4033c9 <.text+0x2f69>
               	jmp	0x403366 <.text+0x2f06>
               	leaq	0xcf33(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rax
               	movq	(%rax), %r14
               	cmpq	$0x9, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x80(%rbp)
               	jmp	0x40328b <.text+0x2e2b>
               	movq	-0x80(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4032f6 <.text+0x2e96>
               	leaq	0xcefd(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movl	$0xd, %eax
               	movq	%rax, (%r14)
               	jmp	0x4032b3 <.text+0x2e53>
               	movl	$0x8e, %r14d
               	movq	%r14, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xced8(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	0xcef4(%rip), %r12      # 0x4101d0
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%r12)
               	cmpq	$0x0, %rax
               	jne	0x403345 <.text+0x2ee5>
               	jmp	0x403333 <.text+0x2ed3>
               	leaq	0xd0f3(%rip), %r12      # 0x4103f0
               	leaq	0xcedc(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4032b3 <.text+0x2e53>
               	movl	$0xc, %r15d
               	movq	%r15, -0x88(%rbp)
               	jmp	0x403357 <.text+0x2ef7>
               	movl	$0xb, %r15d
               	movq	%r15, -0x88(%rbp)
               	jmp	0x403357 <.text+0x2ef7>
               	movq	-0x88(%rbp), %r15
               	movq	%r15, (%r14)
               	jmp	0x403245 <.text+0x2de5>
               	callq	0x400596 <.text+0x136>
               	leaq	0xce2e(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x4, %r14d
               	movq	%r14, (%r12)
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movq	%r15, -0x10(%rbp)
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xce11(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x3a, %r12
               	jne	0x403458 <.text+0x2ff8>
               	jmp	0x4033e5 <.text+0x2f85>
               	jmp	0x403245 <.text+0x2de5>
               	leaq	0xcdf0(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x90, %r12
               	jne	0x403502 <.text+0x30a2>
               	jmp	0x403495 <.text+0x3035>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4033ef <.text+0x2f8f>
               	movq	-0x10(%rbp), %r15
               	leaq	0xcda6(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	addq	$0x18, %r14
               	movq	%r14, (%r15)
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, (%rax)
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movq	%r15, -0x10(%rbp)
               	movl	$0x8f, %r15d
               	movq	%r15, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	-0x10(%rbp), %rax
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	jmp	0x4033c4 <.text+0x2f64>
               	leaq	0xcfaf(%rip), %r14      # 0x41040e
               	leaq	0xcd7a(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4033ef <.text+0x2f8f>
               	callq	0x400596 <.text+0x136>
               	leaq	0xccff(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x5, %r15d
               	movq	%r15, (%r12)
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movq	%rax, -0x10(%rbp)
               	movl	$0x91, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	-0x10(%rbp), %rax
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	leaq	0xcce1(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	0x4034fd <.text+0x309d>
               	jmp	0x4033c4 <.text+0x2f64>
               	leaq	0xccb7(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x91, %rax
               	jne	0x40358c <.text+0x312c>
               	callq	0x400596 <.text+0x136>
               	leaq	0xcc7a(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x4, %r14d
               	movq	%r14, (%r15)
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movq	%rax, -0x10(%rbp)
               	movl	$0x92, %r15d
               	movq	%r15, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	-0x10(%rbp), %rax
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	leaq	0xcc58(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	jmp	0x403587 <.text+0x3127>
               	jmp	0x4034fd <.text+0x309d>
               	leaq	0xcc2d(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x92, %rax
               	jne	0x403603 <.text+0x31a3>
               	callq	0x400596 <.text+0x136>
               	leaq	0xcbf1(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x93, %r14d
               	movq	%r14, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0xe, %r14d
               	movq	%r14, (%rax)
               	leaq	0xcbe0(%rip), %r15      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	jmp	0x4035fe <.text+0x319e>
               	jmp	0x403587 <.text+0x3127>
               	leaq	0xcbb6(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x93, %rax
               	jne	0x40367b <.text+0x321b>
               	callq	0x400596 <.text+0x136>
               	leaq	0xcb7a(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	movl	$0x94, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xf, %r12d
               	movq	%r12, (%rax)
               	leaq	0xcb68(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	0x403676 <.text+0x3216>
               	jmp	0x4035fe <.text+0x319e>
               	leaq	0xcb3e(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x94, %rax
               	jne	0x4036f8 <.text+0x3298>
               	callq	0x400596 <.text+0x136>
               	leaq	0xcb01(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movl	$0x95, %r15d
               	movq	%r15, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x10, %r15d
               	movq	%r15, (%rax)
               	leaq	0xcaec(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	jmp	0x4036f3 <.text+0x3293>
               	jmp	0x403676 <.text+0x3216>
               	leaq	0xcac1(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x95, %rax
               	jne	0x40376f <.text+0x330f>
               	callq	0x400596 <.text+0x136>
               	leaq	0xca85(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x97, %r14d
               	movq	%r14, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x11, %r14d
               	movq	%r14, (%rax)
               	leaq	0xca74(%rip), %r15      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	jmp	0x40376a <.text+0x330a>
               	jmp	0x4036f3 <.text+0x3293>
               	leaq	0xca4a(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x96, %rax
               	jne	0x4037e7 <.text+0x3387>
               	callq	0x400596 <.text+0x136>
               	leaq	0xca0e(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	movl	$0x97, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x12, %r12d
               	movq	%r12, (%rax)
               	leaq	0xc9fc(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	0x4037e2 <.text+0x3382>
               	jmp	0x40376a <.text+0x330a>
               	leaq	0xc9d2(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x97, %rax
               	jne	0x403864 <.text+0x3404>
               	callq	0x400596 <.text+0x136>
               	leaq	0xc995(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movl	$0x9b, %r15d
               	movq	%r15, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x13, %r15d
               	movq	%r15, (%rax)
               	leaq	0xc980(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	jmp	0x40385f <.text+0x33ff>
               	jmp	0x4037e2 <.text+0x3382>
               	leaq	0xc955(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x98, %rax
               	jne	0x4038db <.text+0x347b>
               	callq	0x400596 <.text+0x136>
               	leaq	0xc919(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x9b, %r14d
               	movq	%r14, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x14, %r14d
               	movq	%r14, (%rax)
               	leaq	0xc908(%rip), %r15      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	jmp	0x4038d6 <.text+0x3476>
               	jmp	0x40385f <.text+0x33ff>
               	leaq	0xc8de(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x99, %rax
               	jne	0x403953 <.text+0x34f3>
               	callq	0x400596 <.text+0x136>
               	leaq	0xc8a2(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	movl	$0x9b, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x15, %r12d
               	movq	%r12, (%rax)
               	leaq	0xc890(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	0x40394e <.text+0x34ee>
               	jmp	0x4038d6 <.text+0x3476>
               	leaq	0xc866(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x9a, %rax
               	jne	0x4039d0 <.text+0x3570>
               	callq	0x400596 <.text+0x136>
               	leaq	0xc829(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movl	$0x9b, %r15d
               	movq	%r15, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x16, %r15d
               	movq	%r15, (%rax)
               	leaq	0xc814(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	jmp	0x4039cb <.text+0x356b>
               	jmp	0x40394e <.text+0x34ee>
               	leaq	0xc7e9(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x9b, %rax
               	jne	0x403a47 <.text+0x35e7>
               	callq	0x400596 <.text+0x136>
               	leaq	0xc7ad(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x9d, %r14d
               	movq	%r14, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x17, %r14d
               	movq	%r14, (%rax)
               	leaq	0xc79c(%rip), %r15      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	jmp	0x403a42 <.text+0x35e2>
               	jmp	0x4039cb <.text+0x356b>
               	leaq	0xc772(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x9c, %rax
               	jne	0x403abf <.text+0x365f>
               	callq	0x400596 <.text+0x136>
               	leaq	0xc736(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	movl	$0x9d, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x18, %r12d
               	movq	%r12, (%rax)
               	leaq	0xc724(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	0x403aba <.text+0x365a>
               	jmp	0x403a42 <.text+0x35e2>
               	leaq	0xc6fa(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x9d, %rax
               	jne	0x403b2c <.text+0x36cc>
               	callq	0x400596 <.text+0x136>
               	leaq	0xc6bd(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movl	$0x9f, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xc6c2(%rip), %rax      # 0x4101d0
               	movq	-0x8(%rbp), %r12
               	movq	%r12, (%rax)
               	cmpq	$0x2, %r12
               	jle	0x403baa <.text+0x374a>
               	jmp	0x403b48 <.text+0x36e8>
               	jmp	0x403aba <.text+0x365a>
               	leaq	0xc68d(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x9e, %rax
               	jne	0x403c2e <.text+0x37ce>
               	jmp	0x403bcc <.text+0x376c>
               	leaq	0xc651(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0xd, %eax
               	movq	%rax, (%r12)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x1, %eax
               	movq	%rax, (%r14)
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x8, %eax
               	movq	%rax, (%r12)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x1b, %eax
               	movq	%rax, (%r14)
               	jmp	0x403baa <.text+0x374a>
               	leaq	0xc5ef(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x19, %r14d
               	movq	%r14, (%r15)
               	jmp	0x403b27 <.text+0x36c7>
               	callq	0x400596 <.text+0x136>
               	leaq	0xc5c8(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	movl	$0x9f, %r14d
               	movq	%r14, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2, %rax
               	setg	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x90(%rbp)
               	cmpq	$0x0, %rax
               	je	0x403c6f <.text+0x380f>
               	jmp	0x403c4a <.text+0x37ea>
               	jmp	0x403b27 <.text+0x36c7>
               	leaq	0xc58b(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x9f, %r12
               	jne	0x403e34 <.text+0x39d4>
               	jmp	0x403dd3 <.text+0x3973>
               	movq	-0x8(%rbp), %r14
               	leaq	0xc57b(%rip), %rax      # 0x4101d0
               	movq	(%rax), %r12
               	cmpq	%r12, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x90(%rbp)
               	jmp	0x403c6f <.text+0x380f>
               	movq	-0x90(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x403d14 <.text+0x38b4>
               	leaq	0xc516(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1a, %eax
               	movq	%rax, (%r14)
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %eax
               	movq	%rax, (%r15)
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1, %eax
               	movq	%rax, (%r14)
               	movq	(%r12), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x8, %r14d
               	movq	%r14, (%r15)
               	movq	(%r12), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%r12)
               	movl	$0x1c, %r14d
               	movq	%r14, (%rdx)
               	leaq	0xc4ca(%rip), %r12      # 0x4101d0
               	movq	%rax, (%r12)
               	jmp	0x403d0f <.text+0x38af>
               	jmp	0x403c29 <.text+0x37c9>
               	leaq	0xc4b5(%rip), %r12      # 0x4101d0
               	movq	-0x8(%rbp), %r14
               	movq	%r14, (%r12)
               	cmpq	$0x2, %r14
               	jle	0x403daf <.text+0x394f>
               	leaq	0xc469(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1, %r12d
               	movq	%r12, (%rdx)
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x8, %r12d
               	movq	%r12, (%r14)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1b, %r12d
               	movq	%r12, (%rdx)
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x1a, %r12d
               	movq	%r12, (%r14)
               	jmp	0x403daa <.text+0x394a>
               	jmp	0x403d0f <.text+0x38af>
               	leaq	0xc3ea(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x1a, %r14d
               	movq	%r14, (%rax)
               	jmp	0x403daa <.text+0x394a>
               	callq	0x400596 <.text+0x136>
               	leaq	0xc3c1(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0xd, %r14d
               	movq	%r14, (%r12)
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1b, %r12d
               	movq	%r12, (%rax)
               	leaq	0xc3af(%rip), %r15      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r15)
               	jmp	0x403e2f <.text+0x39cf>
               	jmp	0x403c29 <.text+0x37c9>
               	leaq	0xc385(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0xa0, %rax
               	jne	0x403eb1 <.text+0x3a51>
               	callq	0x400596 <.text+0x136>
               	leaq	0xc348(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x1c, %r14d
               	movq	%r14, (%rax)
               	leaq	0xc333(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	0x403eac <.text+0x3a4c>
               	jmp	0x403e2f <.text+0x39cf>
               	leaq	0xc308(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0xa1, %rax
               	jne	0x403f28 <.text+0x3ac8>
               	callq	0x400596 <.text+0x136>
               	leaq	0xc2cc(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1d, %r15d
               	movq	%r15, (%rax)
               	leaq	0xc2bb(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	jmp	0x403f23 <.text+0x3ac3>
               	jmp	0x403eac <.text+0x3a4c>
               	leaq	0xc291(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0xa2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x98(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x403f7a <.text+0x3b1a>
               	leaq	0xc264(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0xa3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x98(%rbp)
               	jmp	0x403f7a <.text+0x3b1a>
               	movq	-0x98(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x403fb2 <.text+0x3b52>
               	leaq	0xc20b(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	movq	(%rax), %r15
               	cmpq	$0xa, %r15
               	jne	0x40405a <.text+0x3bfa>
               	jmp	0x403fcf <.text+0x3b6f>
               	jmp	0x403f23 <.text+0x3ac3>
               	leaq	0xc207(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0xa4, %rax
               	jne	0x4042fa <.text+0x3e9a>
               	jmp	0x4042a9 <.text+0x3e49>
               	leaq	0xc1ca(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movl	$0xa, %r14d
               	movq	%r14, (%rdx)
               	jmp	0x403ffd <.text+0x3b9d>
               	leaq	0xc19c(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%rax)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	0xc18c(%rip), %r12      # 0x4101d0
               	movq	(%r12), %r15
               	cmpq	$0x2, %r15
               	jle	0x4040f4 <.text+0x3c94>
               	jmp	0x4040e2 <.text+0x3c82>
               	leaq	0xc13f(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rax
               	movq	(%rax), %r14
               	cmpq	$0x9, %r14
               	jne	0x4040a5 <.text+0x3c45>
               	leaq	0xc125(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movl	$0xd, %edx
               	movq	%rdx, (%r14)
               	movq	(%rax), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x9, %edx
               	movq	%rdx, (%r15)
               	jmp	0x4040a0 <.text+0x3c40>
               	jmp	0x403ffd <.text+0x3b9d>
               	leaq	0xc381(%rip), %r12      # 0x41042d
               	leaq	0xc12d(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4040a0 <.text+0x3c40>
               	movl	$0x8, %r12d
               	movq	%r12, -0xa0(%rbp)
               	jmp	0x404106 <.text+0x3ca6>
               	movl	$0x1, %r12d
               	movq	%r12, -0xa0(%rbp)
               	jmp	0x404106 <.text+0x3ca6>
               	movq	-0xa0(%rbp), %r12
               	movq	%r12, (%rax)
               	leaq	0xc089(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	leaq	0xc095(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0xa2, %r15
               	jne	0x40414c <.text+0x3cec>
               	movl	$0x19, %eax
               	movq	%rax, -0xa8(%rbp)
               	jmp	0x40415d <.text+0x3cfd>
               	movl	$0x1a, %eax
               	movq	%rax, -0xa8(%rbp)
               	jmp	0x40415d <.text+0x3cfd>
               	movq	-0xa8(%rbp), %rax
               	movq	%rax, (%r12)
               	leaq	0xc031(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	0xc04d(%rip), %r12      # 0x4101d0
               	movq	(%r12), %r15
               	cmpq	$0x0, %r15
               	jne	0x4041a6 <.text+0x3d46>
               	movl	$0xc, %r12d
               	movq	%r12, -0xb0(%rbp)
               	jmp	0x4041b8 <.text+0x3d58>
               	movl	$0xb, %r12d
               	movq	%r12, -0xb0(%rbp)
               	jmp	0x4041b8 <.text+0x3d58>
               	movq	-0xb0(%rbp), %r12
               	movq	%r12, (%rax)
               	leaq	0xbfd7(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0xd, %eax
               	movq	%rax, (%r12)
               	movq	(%r15), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x1, %eax
               	movq	%rax, (%r14)
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	leaq	0xbfc8(%rip), %rax      # 0x4101d0
               	movq	(%rax), %r15
               	cmpq	$0x2, %r15
               	jle	0x404229 <.text+0x3dc9>
               	movl	$0x8, %eax
               	movq	%rax, -0xb8(%rbp)
               	jmp	0x40423a <.text+0x3dda>
               	movl	$0x1, %eax
               	movq	%rax, -0xb8(%rbp)
               	jmp	0x40423a <.text+0x3dda>
               	movq	-0xb8(%rbp), %rax
               	movq	%rax, (%r12)
               	leaq	0xbf54(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	0xbf60(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0xa2, %r15
               	jne	0x404283 <.text+0x3e23>
               	movl	$0x1a, %r12d
               	movq	%r12, -0xc0(%rbp)
               	jmp	0x404295 <.text+0x3e35>
               	movl	$0x19, %r12d
               	movq	%r12, -0xc0(%rbp)
               	jmp	0x404295 <.text+0x3e35>
               	movq	-0xc0(%rbp), %r12
               	movq	%r12, (%rax)
               	callq	0x400596 <.text+0x136>
               	jmp	0x403fad <.text+0x3b4d>
               	callq	0x400596 <.text+0x136>
               	leaq	0xbeeb(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xbee0(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x5d, %r12
               	jne	0x404364 <.text+0x3f04>
               	jmp	0x404344 <.text+0x3ee4>
               	jmp	0x403fad <.text+0x3b4d>
               	leaq	0xc185(%rip), %r14      # 0x410486
               	leaq	0xbed8(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r12
               	leaq	0xbeae(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4042f5 <.text+0x3e95>
               	callq	0x400596 <.text+0x136>
               	jmp	0x40434e <.text+0x3eee>
               	movq	-0x8(%rbp), %r14
               	cmpq	$0x2, %r14
               	jle	0x404458 <.text+0x3ff8>
               	jmp	0x4043a1 <.text+0x3f41>
               	leaq	0xc0e4(%rip), %r15      # 0x41044f
               	leaq	0xbe6e(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x40434e <.text+0x3eee>
               	leaq	0xbdf8(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	movq	(%rax), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x8, %r15d
               	movq	%r15, (%r14)
               	movq	(%rax), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1b, %r15d
               	movq	%r15, (%r12)
               	jmp	0x404407 <.text+0x3fa7>
               	leaq	0xbd92(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x19, %r14d
               	movq	%r14, (%rax)
               	movq	(%r15), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	leaq	0xbd98(%rip), %r14      # 0x4101d0
               	movq	-0x8(%rbp), %r15
               	subq	$0x2, %r15
               	movq	%r15, (%r14)
               	cmpq	$0x0, %r15
               	jne	0x4044bc <.text+0x405c>
               	jmp	0x4044ab <.text+0x404b>
               	movq	-0x8(%rbp), %r15
               	cmpq	$0x2, %r15
               	jge	0x4044a6 <.text+0x4046>
               	leaq	0xbffb(%rip), %r14      # 0x41046b
               	leaq	0xbd69(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4044a6 <.text+0x4046>
               	jmp	0x404407 <.text+0x3fa7>
               	movl	$0xa, %eax
               	movq	%rax, -0xc8(%rbp)
               	jmp	0x4044cd <.text+0x406d>
               	movl	$0x9, %eax
               	movq	%rax, -0xc8(%rbp)
               	jmp	0x4044cd <.text+0x406d>
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, (%r12)
               	jmp	0x4042f5 <.text+0x3e95>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xbcbe(%rip), %r11      # 0x4101c0
               	movq	(%r11), %r9
               	cmpq	$0x89, %r9
               	jne	0x404558 <.text+0x40f8>
               	callq	0x400596 <.text+0x136>
               	leaq	0xbca2(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x28, %rbx
               	jne	0x4045a7 <.text+0x4147>
               	jmp	0x404574 <.text+0x4114>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xbc61(%rip), %rdi      # 0x4101c0
               	movq	(%rdi), %rax
               	cmpq	$0x8d, %rax
               	jne	0x404725 <.text+0x42c5>
               	jmp	0x4046ea <.text+0x428a>
               	callq	0x400596 <.text+0x136>
               	jmp	0x40457e <.text+0x411e>
               	movl	$0x8e, %ebx
               	movq	%rbx, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xbc2e(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x29, %rbx
               	jne	0x404641 <.text+0x41e1>
               	jmp	0x4045e4 <.text+0x4184>
               	leaq	0xbef2(%rip), %r12      # 0x4104a0
               	leaq	0xbc2b(%rip), %rax      # 0x4101e0
               	movq	(%rax), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x40457e <.text+0x411e>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4045ee <.text+0x418e>
               	leaq	0xbbab(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x4, %r14d
               	movq	%r14, (%rax)
               	movq	(%r12), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
               	movq	%rdi, -0x10(%rbp)
               	callq	0x4044dd <.text+0x407d>
               	leaq	0xbb94(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rdi
               	cmpq	$0x87, %rdi
               	jne	0x4046cc <.text+0x426c>
               	jmp	0x40467e <.text+0x421e>
               	leaq	0xbe71(%rip), %r14      # 0x4104b9
               	leaq	0xbb91(%rip), %rax      # 0x4101e0
               	movq	(%rax), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4045ee <.text+0x418e>
               	movq	-0x10(%rbp), %rax
               	leaq	0xbb17(%rip), %rdi      # 0x4101a0
               	movq	(%rdi), %r12
               	addq	$0x18, %r12
               	movq	%r12, (%rax)
               	movq	(%rdi), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rdi)
               	movl	$0x2, %r12d
               	movq	%r12, (%r14)
               	movq	(%rdi), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdi)
               	movq	%rax, -0x10(%rbp)
               	callq	0x400596 <.text+0x136>
               	callq	0x4044dd <.text+0x407d>
               	jmp	0x4046cc <.text+0x426c>
               	movq	-0x10(%rbp), %r12
               	leaq	0xbac9(%rip), %rax      # 0x4101a0
               	movq	(%rax), %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, (%r12)
               	jmp	0x404533 <.text+0x40d3>
               	callq	0x400596 <.text+0x136>
               	leaq	0xbaaa(%rip), %rax      # 0x4101a0
               	movq	(%rax), %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, -0x8(%rbp)
               	leaq	0xbab5(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x28, %rbx
               	jne	0x404774 <.text+0x4314>
               	jmp	0x404741 <.text+0x42e1>
               	jmp	0x404533 <.text+0x40d3>
               	leaq	0xba94(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x8b, %rbx
               	jne	0x404892 <.text+0x4432>
               	jmp	0x40486c <.text+0x440c>
               	callq	0x400596 <.text+0x136>
               	jmp	0x40474b <.text+0x42eb>
               	movl	$0x8e, %ebx
               	movq	%rbx, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xba61(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x29, %rbx
               	jne	0x40482f <.text+0x43cf>
               	jmp	0x4047b1 <.text+0x4351>
               	leaq	0xbd58(%rip), %r15      # 0x4104d3
               	leaq	0xba5e(%rip), %rax      # 0x4101e0
               	movq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x40474b <.text+0x42eb>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4047bb <.text+0x435b>
               	leaq	0xb9de(%rip), %rbx      # 0x4101a0
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x4, %r12d
               	movq	%r12, (%rax)
               	movq	(%rbx), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	%r14, -0x10(%rbp)
               	callq	0x4044dd <.text+0x407d>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x2, %r14d
               	movq	%r14, (%rax)
               	movq	(%rbx), %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rbx)
               	movq	-0x8(%rbp), %r14
               	movq	%r14, (%r12)
               	movq	-0x10(%rbp), %rax
               	movq	(%rbx), %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	jmp	0x404720 <.text+0x42c0>
               	leaq	0xbcb6(%rip), %r12      # 0x4104ec
               	leaq	0xb9a3(%rip), %rax      # 0x4101e0
               	movq	(%rax), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4047bb <.text+0x435b>
               	callq	0x400596 <.text+0x136>
               	leaq	0xb948(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x3b, %rbx
               	je	0x4048c1 <.text+0x4461>
               	jmp	0x4048ae <.text+0x444e>
               	jmp	0x404720 <.text+0x42c0>
               	leaq	0xb927(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x7b, %rax
               	jne	0x404950 <.text+0x44f0>
               	jmp	0x404941 <.text+0x44e1>
               	movl	$0x8e, %r15d
               	movq	%r15, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	jmp	0x4048c1 <.text+0x4461>
               	leaq	0xb8d8(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x8, %r14d
               	movq	%r14, (%rax)
               	leaq	0xb8db(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x3b, %r14
               	jne	0x404904 <.text+0x44a4>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4048ff <.text+0x449f>
               	jmp	0x40488d <.text+0x442d>
               	leaq	0xbbfb(%rip), %rbx      # 0x410506
               	leaq	0xb8ce(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4048ff <.text+0x449f>
               	callq	0x400596 <.text+0x136>
               	jmp	0x40496c <.text+0x450c>
               	jmp	0x40488d <.text+0x442d>
               	leaq	0xb869(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x3b, %rax
               	jne	0x4049a9 <.text+0x4549>
               	jmp	0x40499a <.text+0x453a>
               	leaq	0xb84d(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x7d, %rax
               	je	0x404990 <.text+0x4530>
               	callq	0x4044dd <.text+0x407d>
               	movq	%rax, %r14
               	jmp	0x40496c <.text+0x450c>
               	callq	0x400596 <.text+0x136>
               	jmp	0x40494b <.text+0x44eb>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4049a4 <.text+0x4544>
               	jmp	0x40494b <.text+0x44eb>
               	movl	$0x8e, %r14d
               	movq	%r14, %rdi
               	callq	0x40207c <.text+0x1c1c>
               	leaq	0xb802(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x3b, %r14
               	jne	0x4049dd <.text+0x457d>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4049d8 <.text+0x4578>
               	jmp	0x4049a4 <.text+0x4544>
               	leaq	0xbb3a(%rip), %r15      # 0x41051e
               	leaq	0xb7f5(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x406d39 <exit>
               	movslq	%eax, %rax
               	jmp	0x4049d8 <.text+0x4578>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r11
               	movq	%r11, 0x10(%rbp)
               	movq	%rsi, %r9
               	movq	%r9, 0x20(%rbp)
               	leaq	0x10(%rbp), %r11
               	movq	(%r11), %r9
               	addq	$-0x1, %r9
               	movq	%r9, (%r11)
               	leaq	0x20(%rbp), %r8
               	movq	(%r8), %r9
               	addq	$0x8, %r9
               	movq	%r9, (%r8)
               	movq	0x10(%rbp), %r11
               	cmpq	$0x0, %r11
               	setg	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa0(%rbp)
               	cmpq	$0x0, %r11
               	je	0x404adf <.text+0x467f>
               	movq	0x20(%rbp), %r9
               	movq	(%r9), %r11
               	movzbq	(%r11), %r9
               	xorq	$0x2d, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	sete	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xa0(%rbp)
               	jmp	0x404adf <.text+0x467f>
               	movq	-0xa0(%rbp), %r9
               	movq	%r9, -0x98(%rbp)
               	cmpq	$0x0, %r9
               	je	0x404b37 <.text+0x46d7>
               	movq	0x20(%rbp), %r11
               	movq	(%r11), %r9
               	addq	$0x1, %r9
               	movzbq	(%r9), %r11
               	xorq	$0x73, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x98(%rbp)
               	jmp	0x404b37 <.text+0x46d7>
               	movq	-0x98(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x404b82 <.text+0x4722>
               	leaq	0xb696(%rip), %r9       # 0x4101e8
               	movl	$0x1, %r11d
               	movq	%r11, (%r9)
               	leaq	0x10(%rbp), %r8
               	movq	(%r8), %r11
               	addq	$-0x1, %r11
               	movq	%r11, (%r8)
               	leaq	0x20(%rbp), %r9
               	movq	(%r9), %r11
               	addq	$0x8, %r11
               	movq	%r11, (%r9)
               	jmp	0x404b82 <.text+0x4722>
               	movq	0x10(%rbp), %r11
               	cmpq	$0x0, %r11
               	setg	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xb0(%rbp)
               	cmpq	$0x0, %r11
               	je	0x404bdf <.text+0x477f>
               	movq	0x20(%rbp), %r8
               	movq	(%r8), %r11
               	movzbq	(%r11), %r8
               	xorq	$0x2d, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0xb0(%rbp)
               	jmp	0x404bdf <.text+0x477f>
               	movq	-0xb0(%rbp), %r8
               	movq	%r8, -0xa8(%rbp)
               	cmpq	$0x0, %r8
               	je	0x404c37 <.text+0x47d7>
               	movq	0x20(%rbp), %r11
               	movq	(%r11), %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r11
               	xorq	$0x64, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa8(%rbp)
               	jmp	0x404c37 <.text+0x47d7>
               	movq	-0xa8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x404c82 <.text+0x4822>
               	leaq	0xb59e(%rip), %r8       # 0x4101f0
               	movl	$0x1, %r11d
               	movq	%r11, (%r8)
               	leaq	0x10(%rbp), %r9
               	movq	(%r9), %r11
               	addq	$-0x1, %r11
               	movq	%r11, (%r9)
               	leaq	0x20(%rbp), %r8
               	movq	(%r8), %r11
               	addq	$0x8, %r11
               	movq	%r11, (%r8)
               	jmp	0x404c82 <.text+0x4822>
               	movq	0x10(%rbp), %r11
               	cmpq	$0x1, %r11
               	jge	0x404cde <.text+0x487e>
               	leaq	0xb89c(%rip), %rbx      # 0x410536
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	0x20(%rbp), %rbx
               	movq	(%rbx), %r12
               	xorq	%r14, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d3f <open>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	jge	0x404d5d <.text+0x48fd>
               	leaq	0xb845(%rip), %r15      # 0x410554
               	movq	0x20(%rbp), %r14
               	movq	(%r14), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movl	$0x40000, %r12d         # imm = 0x40000
               	movslq	%r12d, %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0xb446(%rip), %r14      # 0x4101b8
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x406d45 <malloc>
               	movq	%rax, (%r14)
               	cmpq	$0x0, %rax
               	jne	0x404dde <.text+0x497e>
               	leaq	0xb7d3(%rip), %r15      # 0x410568
               	movq	%r15, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xb3c3(%rip), %r14      # 0x4101a8
               	leaq	0xb3b4(%rip), %r15      # 0x4101a0
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x406d45 <malloc>
               	movq	%rax, (%r15)
               	movq	%rax, (%r14)
               	cmpq	$0x0, %rax
               	jne	0x404e5b <.text+0x49fb>
               	leaq	0xb778(%rip), %r15      # 0x41058a
               	movq	%r15, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xb336(%rip), %r14      # 0x410198
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x406d45 <malloc>
               	movq	%rax, (%r14)
               	cmpq	$0x0, %rax
               	jne	0x404ece <.text+0x4a6e>
               	leaq	0xb725(%rip), %r14      # 0x4105aa
               	movq	%r14, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x406d45 <malloc>
               	movq	%rax, -0x38(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x404f3b <.text+0x4adb>
               	leaq	0xb6d8(%rip), %r15      # 0x4105ca
               	movq	%r15, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xb276(%rip), %r15      # 0x4101b8
               	movq	(%r15), %r14
               	xorq	%r15, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	0x406d4b <memset>
               	leaq	0xb23f(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	0x406d4b <memset>
               	leaq	0xb21b(%rip), %rax      # 0x410198
               	movq	(%rax), %r14
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	0x406d4b <memset>
               	leaq	0xb1ef(%rip), %rax      # 0x410188
               	leaq	0xb64b(%rip), %r14      # 0x4105eb
               	movq	%r14, (%rax)
               	movl	$0x86, %r15d
               	movq	%r15, -0x58(%rbp)
               	jmp	0x404fb2 <.text+0x4b52>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x8d, %r15
               	jg	0x404fee <.text+0x4b8e>
               	callq	0x400596 <.text+0x136>
               	leaq	0xb1e1(%rip), %rax      # 0x4101b0
               	movq	(%rax), %r15
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %r14
               	movq	%r14, %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rax)
               	movq	%r14, (%r15)
               	jmp	0x404fb2 <.text+0x4b52>
               	movl	$0x1e, %r14d
               	movq	%r14, -0x58(%rbp)
               	jmp	0x404ffd <.text+0x4b9d>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x26, %r14
               	jg	0x405066 <.text+0x4c06>
               	callq	0x400596 <.text+0x136>
               	leaq	0xb196(%rip), %rax      # 0x4101b0
               	movq	(%rax), %r14
               	addq	$0x18, %r14
               	movl	$0x82, %r15d
               	movq	%r15, (%r14)
               	movq	(%rax), %rdx
               	addq	$0x20, %rdx
               	movl	$0x1, %r15d
               	movq	%r15, (%rdx)
               	movq	(%rax), %r14
               	addq	$0x28, %r14
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rax)
               	movq	%r15, (%r14)
               	jmp	0x404ffd <.text+0x4b9d>
               	callq	0x400596 <.text+0x136>
               	leaq	0xb13e(%rip), %r15      # 0x4101b0
               	movq	(%r15), %r12
               	movl	$0x86, %r14d
               	movq	%r14, (%r12)
               	callq	0x400596 <.text+0x136>
               	movq	(%r15), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	0xb0fd(%rip), %r14      # 0x410190
               	leaq	0xb0ee(%rip), %r15      # 0x410188
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x406d45 <malloc>
               	movq	%rax, (%r15)
               	movq	%rax, (%r14)
               	cmpq	$0x0, %rax
               	jne	0x405109 <.text+0x4ca9>
               	leaq	0xb595(%rip), %r15      # 0x410655
               	movq	%r15, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xb078(%rip), %r15      # 0x410188
               	movq	(%r15), %r14
               	movq	0x48(%rsp), %r15
               	subq	$0x1, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x406d51 <read>
               	movslq	%eax, %rax
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x0, %rax
               	jg	0x405195 <.text+0x4d35>
               	leaq	0xb52d(%rip), %r14      # 0x410677
               	movq	-0x58(%rbp), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xafec(%rip), %r15      # 0x410188
               	movq	(%r15), %rax
               	movq	-0x58(%rbp), %r15
               	addq	%r15, %rax
               	xorq	%r15, %r15
               	movb	%r15b, (%rax)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x406d57 <close>
               	movslq	%eax, %rax
               	leaq	0xb020(%rip), %rax      # 0x4101e0
               	movl	$0x1, %ebx
               	movq	%rbx, (%rax)
               	callq	0x400596 <.text+0x136>
               	jmp	0x4051d2 <.text+0x4d72>
               	leaq	0xafe7(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rax
               	cmpq	$0x0, %rax
               	je	0x40520e <.text+0x4dae>
               	movl	$0x1, %ebx
               	movq	%rbx, -0x10(%rbp)
               	leaq	0xafc7(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x8a, %rbx
               	jne	0x405242 <.text+0x4de2>
               	jmp	0x405233 <.text+0x4dd3>
               	movq	0x40(%rsp), %r15
               	addq	$0x28, %r15
               	movq	(%r15), %rax
               	movq	%rax, -0x30(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x405ea9 <.text+0x5a49>
               	jmp	0x405e5e <.text+0x59fe>
               	callq	0x400596 <.text+0x136>
               	jmp	0x40523d <.text+0x4ddd>
               	jmp	0x4054ae <.text+0x504e>
               	leaq	0xaf77(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rax
               	cmpq	$0x86, %rax
               	jne	0x40526f <.text+0x4e0f>
               	callq	0x400596 <.text+0x136>
               	xorq	%rax, %rax
               	movq	%rax, -0x10(%rbp)
               	jmp	0x40526a <.text+0x4e0a>
               	jmp	0x40523d <.text+0x4ddd>
               	leaq	0xaf4a(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x88, %r14
               	jne	0x4052a7 <.text+0x4e47>
               	callq	0x400596 <.text+0x136>
               	leaq	0xaf2e(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x7b, %r14
               	je	0x4052b6 <.text+0x4e56>
               	jmp	0x4052ac <.text+0x4e4c>
               	jmp	0x40526a <.text+0x4e0a>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4052b6 <.text+0x4e56>
               	leaq	0xaf03(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x7b, %rax
               	jne	0x4052de <.text+0x4e7e>
               	callq	0x400596 <.text+0x136>
               	xorq	%rax, %rax
               	movq	%rax, -0x58(%rbp)
               	jmp	0x4052e3 <.text+0x4e83>
               	jmp	0x4052a7 <.text+0x4e47>
               	leaq	0xaed6(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x7d, %rbx
               	je	0x405316 <.text+0x4eb6>
               	leaq	0xaebf(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x85, %rbx
               	je	0x405385 <.text+0x4f25>
               	jmp	0x405320 <.text+0x4ec0>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4052de <.text+0x4e7e>
               	leaq	0xb364(%rip), %r14      # 0x41068b
               	leaq	0xaeb2(%rip), %rbx      # 0x4101e0
               	movq	(%rbx), %r15
               	leaq	0xae88(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	callq	0x400596 <.text+0x136>
               	leaq	0xae2f(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x8e, %rbx
               	jne	0x4053c2 <.text+0x4f62>
               	callq	0x400596 <.text+0x136>
               	leaq	0xae13(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x80, %rbx
               	je	0x405484 <.text+0x5024>
               	jmp	0x40542c <.text+0x4fcc>
               	leaq	0xade7(%rip), %r14      # 0x4101b0
               	movq	(%r14), %rax
               	addq	$0x18, %rax
               	movl	$0x80, %r12d
               	movq	%r12, (%rax)
               	movq	(%r14), %r15
               	addq	$0x20, %r15
               	movl	$0x1, %r12d
               	movq	%r12, (%r15)
               	movq	(%r14), %rax
               	addq	$0x28, %rax
               	leaq	-0x58(%rbp), %r14
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%r14)
               	movq	%r12, (%rax)
               	leaq	0xada9(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r12
               	cmpq	$0x2c, %r12
               	jne	0x4054a9 <.text+0x5049>
               	jmp	0x40549c <.text+0x503c>
               	leaq	0xb274(%rip), %r12      # 0x4106a7
               	leaq	0xada6(%rip), %rbx      # 0x4101e0
               	movq	(%rbx), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xad3d(%rip), %r14      # 0x4101c8
               	movq	(%r14), %rax
               	movq	%rax, -0x58(%rbp)
               	callq	0x400596 <.text+0x136>
               	jmp	0x4053c2 <.text+0x4f62>
               	callq	0x400596 <.text+0x136>
               	movq	%rax, %r14
               	jmp	0x4054a9 <.text+0x5049>
               	jmp	0x4052e3 <.text+0x4e83>
               	leaq	0xad0b(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x3b, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	cmpq	$0x0, %rax
               	je	0x40551c <.text+0x50bc>
               	jmp	0x4054f7 <.text+0x5097>
               	movq	-0x10(%rbp), %r14
               	movq	%r14, -0x18(%rbp)
               	jmp	0x405535 <.text+0x50d5>
               	callq	0x400596 <.text+0x136>
               	jmp	0x4051d2 <.text+0x4d72>
               	leaq	0xacc2(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x7d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	jmp	0x40551c <.text+0x50bc>
               	movq	-0xb8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x4054ed <.text+0x508d>
               	jmp	0x4054e0 <.text+0x5080>
               	leaq	0xac84(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x9f, %rax
               	jne	0x405565 <.text+0x5105>
               	callq	0x400596 <.text+0x136>
               	movq	-0x18(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	0x405535 <.text+0x50d5>
               	leaq	0xac54(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x85, %rbx
               	je	0x4055d4 <.text+0x5174>
               	leaq	0xb13e(%rip), %r14      # 0x4106c1
               	leaq	0xac56(%rip), %rbx      # 0x4101e0
               	movq	(%rbx), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xabd5(%rip), %r15      # 0x4101b0
               	movq	(%r15), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r15
               	cmpq	$0x0, %r15
               	je	0x40564d <.text+0x51ed>
               	leaq	0xb0e1(%rip), %rbx      # 0x4106dd
               	leaq	0xabdd(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	callq	0x400596 <.text+0x136>
               	leaq	0xab57(%rip), %rax      # 0x4101b0
               	movq	(%rax), %r15
               	addq	$0x20, %r15
               	movq	-0x18(%rbp), %rax
               	movq	%rax, (%r15)
               	leaq	0xab4f(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rax
               	cmpq	$0x28, %rax
               	jne	0x4056e6 <.text+0x5286>
               	leaq	0xab28(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %rax
               	addq	$0x18, %rax
               	movl	$0x81, %r15d
               	movq	%r15, (%rax)
               	movq	(%rbx), %r14
               	addq	$0x28, %r14
               	leaq	0xaaf4(%rip), %rbx      # 0x4101a0
               	movq	(%rbx), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	callq	0x400596 <.text+0x136>
               	xorq	%rax, %rax
               	movq	%rax, -0x58(%rbp)
               	jmp	0x405729 <.text+0x52c9>
               	leaq	0xaaef(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x2c, %rax
               	jne	0x405e59 <.text+0x59f9>
               	jmp	0x405e4c <.text+0x59ec>
               	leaq	0xaac3(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %r15
               	addq	$0x18, %r15
               	movl	$0x83, %eax
               	movq	%rax, (%r15)
               	movq	(%rbx), %r12
               	addq	$0x28, %r12
               	leaq	0xaa88(%rip), %rbx      # 0x410198
               	movq	(%rbx), %rax
               	movq	%rax, (%r12)
               	movq	(%rbx), %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rbx)
               	jmp	0x4056ca <.text+0x526a>
               	leaq	0xaa90(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x29, %r15
               	je	0x405765 <.text+0x5305>
               	movl	$0x1, %eax
               	movq	%rax, -0x18(%rbp)
               	leaq	0xaa70(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x8a, %rax
               	jne	0x405795 <.text+0x5335>
               	jmp	0x405786 <.text+0x5326>
               	callq	0x400596 <.text+0x136>
               	leaq	0xaa4f(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x7b, %r14
               	je	0x4059fd <.text+0x559d>
               	jmp	0x4059a5 <.text+0x5545>
               	callq	0x400596 <.text+0x136>
               	jmp	0x405790 <.text+0x5330>
               	jmp	0x4057c3 <.text+0x5363>
               	leaq	0xaa24(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x86, %rax
               	jne	0x4057be <.text+0x535e>
               	callq	0x400596 <.text+0x136>
               	xorq	%rax, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	0x4057be <.text+0x535e>
               	jmp	0x405790 <.text+0x5330>
               	leaq	0xa9f6(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x9f, %r15
               	jne	0x4057f3 <.text+0x5393>
               	callq	0x400596 <.text+0x136>
               	movq	-0x18(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	0x4057c3 <.text+0x5363>
               	leaq	0xa9c6(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x85, %r15
               	je	0x405862 <.text+0x5402>
               	leaq	0xaeed(%rip), %r12      # 0x4106fe
               	leaq	0xa9c8(%rip), %r15      # 0x4101e0
               	movq	(%r15), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa947(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rbx
               	cmpq	$0x84, %rbx
               	jne	0x4058db <.text+0x547b>
               	leaq	0xae93(%rip), %r15      # 0x41071d
               	leaq	0xa94f(%rip), %rbx      # 0x4101e0
               	movq	(%rbx), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa8ce(%rip), %r14      # 0x4101b0
               	movq	(%r14), %rax
               	addq	$0x30, %rax
               	movq	(%r14), %r15
               	addq	$0x18, %r15
               	movq	(%r15), %r12
               	movq	%r12, (%rax)
               	movq	(%r14), %r15
               	addq	$0x18, %r15
               	movl	$0x84, %r12d
               	movq	%r12, (%r15)
               	movq	(%r14), %rax
               	addq	$0x38, %rax
               	movq	(%r14), %r12
               	addq	$0x20, %r12
               	movq	(%r12), %r15
               	movq	%r15, (%rax)
               	movq	(%r14), %r12
               	addq	$0x20, %r12
               	movq	-0x18(%rbp), %r15
               	movq	%r15, (%r12)
               	movq	(%r14), %rax
               	addq	$0x40, %rax
               	movq	(%r14), %r15
               	addq	$0x28, %r15
               	movq	(%r15), %r12
               	movq	%r12, (%rax)
               	movq	(%r14), %r15
               	addq	$0x28, %r15
               	leaq	-0x58(%rbp), %r14
               	movq	(%r14), %r12
               	movq	%r12, %rax
               	addq	$0x1, %rax
               	movq	%rax, (%r14)
               	movq	%r12, (%r15)
               	callq	0x400596 <.text+0x136>
               	leaq	0xa83d(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x2c, %r12
               	jne	0x4059a0 <.text+0x5540>
               	callq	0x400596 <.text+0x136>
               	movq	%rax, %r14
               	jmp	0x4059a0 <.text+0x5540>
               	jmp	0x405729 <.text+0x52c9>
               	leaq	0xad95(%rip), %r12      # 0x410741
               	leaq	0xa82d(%rip), %r14      # 0x4101e0
               	movq	(%r14), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa7d4(%rip), %rbx      # 0x4101d8
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rax)
               	movq	%r12, (%rbx)
               	callq	0x400596 <.text+0x136>
               	jmp	0x405a22 <.text+0x55c2>
               	leaq	0xa797(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x8a, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc0(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x405adb <.text+0x567b>
               	jmp	0x405ab5 <.text+0x5655>
               	leaq	0xa764(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x8a, %rax
               	jne	0x405b06 <.text+0x56a6>
               	jmp	0x405af4 <.text+0x5694>
               	leaq	0xa727(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x6, %r14d
               	movq	%r14, (%rax)
               	movq	(%r15), %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movq	-0x58(%rbp), %r14
               	leaq	0xa731(%rip), %r15      # 0x4101d8
               	movq	(%r15), %rax
               	subq	%rax, %r14
               	movq	%r14, (%rbx)
               	jmp	0x405d39 <.text+0x58d9>
               	leaq	0xa704(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x86, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc0(%rbp)
               	jmp	0x405adb <.text+0x567b>
               	movq	-0xc0(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x405a72 <.text+0x5612>
               	jmp	0x405a55 <.text+0x55f5>
               	movl	$0x1, %r12d
               	movq	%r12, -0xc8(%rbp)
               	jmp	0x405b15 <.text+0x56b5>
               	xorq	%r12, %r12
               	movq	%r12, -0xc8(%rbp)
               	jmp	0x405b15 <.text+0x56b5>
               	movq	-0xc8(%rbp), %r12
               	movq	%r12, -0x10(%rbp)
               	callq	0x400596 <.text+0x136>
               	jmp	0x405b2a <.text+0x56ca>
               	leaq	0xa68f(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x3b, %rax
               	je	0x405b4f <.text+0x56ef>
               	movq	-0x10(%rbp), %r12
               	movq	%r12, -0x18(%rbp)
               	jmp	0x405b59 <.text+0x56f9>
               	callq	0x400596 <.text+0x136>
               	jmp	0x405a22 <.text+0x55c2>
               	leaq	0xa660(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	0x405b8a <.text+0x572a>
               	callq	0x400596 <.text+0x136>
               	movq	-0x18(%rbp), %rax
               	addq	$0x2, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	0x405b59 <.text+0x56f9>
               	leaq	0xa62f(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x85, %r14
               	je	0x405bf9 <.text+0x5799>
               	leaq	0xabb6(%rip), %r12      # 0x41075e
               	leaq	0xa631(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa5b0(%rip), %r15      # 0x4101b0
               	movq	(%r15), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r15
               	cmpq	$0x84, %r15
               	jne	0x405c72 <.text+0x5812>
               	leaq	0xab58(%rip), %r14      # 0x410779
               	leaq	0xa5b8(%rip), %r15      # 0x4101e0
               	movq	(%r15), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa537(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %rax
               	addq	$0x30, %rax
               	movq	(%rbx), %r14
               	addq	$0x18, %r14
               	movq	(%r14), %r12
               	movq	%r12, (%rax)
               	movq	(%rbx), %r14
               	addq	$0x18, %r14
               	movl	$0x84, %r12d
               	movq	%r12, (%r14)
               	movq	(%rbx), %rax
               	addq	$0x38, %rax
               	movq	(%rbx), %r12
               	addq	$0x20, %r12
               	movq	(%r12), %r14
               	movq	%r14, (%rax)
               	movq	(%rbx), %r12
               	addq	$0x20, %r12
               	movq	-0x18(%rbp), %r14
               	movq	%r14, (%r12)
               	movq	(%rbx), %rax
               	addq	$0x40, %rax
               	movq	(%rbx), %r14
               	addq	$0x28, %r14
               	movq	(%r14), %r12
               	movq	%r12, (%rax)
               	movq	(%rbx), %r14
               	addq	$0x28, %r14
               	leaq	-0x58(%rbp), %rbx
               	movq	(%rbx), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rbx)
               	movq	%r12, (%r14)
               	callq	0x400596 <.text+0x136>
               	leaq	0xa4a9(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x2c, %r12
               	jne	0x405d34 <.text+0x58d4>
               	callq	0x400596 <.text+0x136>
               	movq	%rax, %r15
               	jmp	0x405d34 <.text+0x58d4>
               	jmp	0x405b2a <.text+0x56ca>
               	leaq	0xa480(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x7d, %rax
               	je	0x405d5a <.text+0x58fa>
               	callq	0x4044dd <.text+0x407d>
               	jmp	0x405d39 <.text+0x58d9>
               	leaq	0xa43f(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x8, %ebx
               	movq	%rbx, (%rax)
               	leaq	0xa431(%rip), %r12      # 0x4101b0
               	leaq	0xa432(%rip), %rbx      # 0x4101b8
               	movq	(%rbx), %rax
               	movq	%rax, (%r12)
               	jmp	0x405d92 <.text+0x5932>
               	leaq	0xa417(%rip), %rax      # 0x4101b0
               	movq	(%rax), %rbx
               	movq	(%rbx), %rax
               	cmpq	$0x0, %rax
               	je	0x405dd2 <.text+0x5972>
               	leaq	0xa3fd(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rbx
               	cmpq	$0x84, %rbx
               	jne	0x405e33 <.text+0x59d3>
               	jmp	0x405dd7 <.text+0x5977>
               	jmp	0x4056ca <.text+0x526a>
               	leaq	0xa3d2(%rip), %rax      # 0x4101b0
               	movq	(%rax), %rbx
               	addq	$0x18, %rbx
               	movq	(%rax), %r12
               	addq	$0x30, %r12
               	movq	(%r12), %r15
               	movq	%r15, (%rbx)
               	movq	(%rax), %r12
               	addq	$0x20, %r12
               	movq	(%rax), %r15
               	addq	$0x38, %r15
               	movq	(%r15), %rbx
               	movq	%rbx, (%r12)
               	movq	(%rax), %r15
               	addq	$0x28, %r15
               	movq	(%rax), %rbx
               	addq	$0x40, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, (%r15)
               	jmp	0x405e33 <.text+0x59d3>
               	leaq	0xa376(%rip), %rax      # 0x4101b0
               	movq	(%rax), %rbx
               	addq	$0x48, %rbx
               	movq	%rbx, (%rax)
               	jmp	0x405d92 <.text+0x5932>
               	callq	0x400596 <.text+0x136>
               	movq	%rax, %r15
               	jmp	0x405e59 <.text+0x59f9>
               	jmp	0x4054ae <.text+0x504e>
               	leaq	0xa934(%rip), %r14      # 0x410799
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa338(%rip), %r14      # 0x4101e8
               	movq	(%r14), %rax
               	cmpq	$0x0, %rax
               	je	0x405ef0 <.text+0x5a90>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	-0x38(%rbp), %rax
               	movq	0x48(%rsp), %r10
               	addq	%r10, %rax
               	movq	%rax, -0x38(%rbp)
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rax
               	addq	$-0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x26, %ebx
               	movq	%rbx, (%rax)
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rbx
               	addq	$-0x8, %rbx
               	movq	%rbx, (%r14)
               	movl	$0xd, %eax
               	movq	%rax, (%rbx)
               	movq	-0x38(%rbp), %r14
               	movq	%r14, -0x60(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%rax)
               	movq	0x10(%rbp), %rbx
               	movq	%rbx, (%r14)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rbx
               	addq	$-0x8, %rbx
               	movq	%rbx, (%rax)
               	movq	0x20(%rbp), %r14
               	movq	%r14, (%rbx)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%rax)
               	movq	-0x60(%rbp), %rbx
               	movq	%rbx, (%r14)
               	xorq	%rax, %rax
               	movq	%rax, -0x50(%rbp)
               	jmp	0x405f92 <.text+0x5b32>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	je	0x405fec <.text+0x5b8c>
               	leaq	-0x30(%rbp), %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%rax), %r12
               	movq	%r12, -0x58(%rbp)
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rax)
               	leaq	0xa219(%rip), %r14      # 0x4101f0
               	movq	(%r14), %r12
               	cmpq	$0x0, %r12
               	je	0x40606b <.text+0x5c0b>
               	jmp	0x40601c <.text+0x5bbc>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa78a(%rip), %r15      # 0x4107ad
               	movq	-0x50(%rbp), %r14
               	leaq	0xa788(%rip), %rax      # 0x4107b6
               	movq	-0x58(%rbp), %rbx
               	movl	$0x5, %r11d
               	imulq	%r11, %rbx
               	movq	%rax, %r12
               	addq	%rbx, %r12
               	movq	%r15, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x7, %rax
               	jg	0x4060a9 <.text+0x5c49>
               	jmp	0x406081 <.text+0x5c21>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x0, %r14
               	jne	0x4060f2 <.text+0x5c92>
               	jmp	0x4060c2 <.text+0x5c62>
               	leaq	0xa7f2(%rip), %rbx      # 0x41087a
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	jmp	0x4060a4 <.text+0x5c44>
               	jmp	0x40606b <.text+0x5c0b>
               	leaq	0xa7cf(%rip), %r14      # 0x41087f
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	jmp	0x4060a4 <.text+0x5c44>
               	movq	-0x40(%rbp), %rax
               	leaq	-0x30(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movq	(%rbx), %r12
               	shlq	$0x3, %r12
               	addq	%r12, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x4060ed <.text+0x5c8d>
               	jmp	0x405f92 <.text+0x5b32>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	0x40612a <.text+0x5cca>
               	leaq	-0x30(%rbp), %r12
               	movq	(%r12), %rax
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r12)
               	movq	(%rax), %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x406125 <.text+0x5cc5>
               	jmp	0x4060ed <.text+0x5c8d>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x2, %r15
               	jne	0x406150 <.text+0x5cf0>
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, -0x30(%rbp)
               	jmp	0x40614b <.text+0x5ceb>
               	jmp	0x406125 <.text+0x5cc5>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x3, %r15
               	jne	0x406195 <.text+0x5d35>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r15
               	addq	$-0x8, %r15
               	movq	%r15, (%rax)
               	movq	-0x30(%rbp), %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	%rbx, -0x30(%rbp)
               	jmp	0x406190 <.text+0x5d30>
               	jmp	0x40614b <.text+0x5ceb>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x4, %rbx
               	jne	0x4061c1 <.text+0x5d61>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x4061ee <.text+0x5d8e>
               	jmp	0x4061d7 <.text+0x5d77>
               	jmp	0x406190 <.text+0x5d30>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x5, %rax
               	jne	0x40622c <.text+0x5dcc>
               	jmp	0x406211 <.text+0x5db1>
               	movq	-0x30(%rbp), %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, -0xd0(%rbp)
               	jmp	0x406201 <.text+0x5da1>
               	movq	-0x30(%rbp), %rbx
               	movq	(%rbx), %rax
               	movq	%rax, -0xd0(%rbp)
               	jmp	0x406201 <.text+0x5da1>
               	movq	-0xd0(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	0x4061bc <.text+0x5d5c>
               	movq	-0x48(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x406255 <.text+0x5df5>
               	jmp	0x406242 <.text+0x5de2>
               	jmp	0x4061bc <.text+0x5d5c>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x6, %rbx
               	jne	0x4062c8 <.text+0x5e68>
               	jmp	0x40627c <.text+0x5e1c>
               	movq	-0x30(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	%rbx, -0xd8(%rbp)
               	jmp	0x40626c <.text+0x5e0c>
               	movq	-0x30(%rbp), %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, -0xd8(%rbp)
               	jmp	0x40626c <.text+0x5e0c>
               	movq	-0xd8(%rbp), %rbx
               	movq	%rbx, -0x30(%rbp)
               	jmp	0x406227 <.text+0x5dc7>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rbx
               	addq	$-0x8, %rbx
               	movq	%rbx, (%rax)
               	movq	-0x40(%rbp), %r15
               	movq	%r15, (%rbx)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x30(%rbp), %r15
               	movq	(%r15), %rbx
               	movq	%rbx, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movq	(%rbx), %r14
               	shlq	$0x3, %r14
               	subq	%r14, %rax
               	movq	%rax, -0x38(%rbp)
               	jmp	0x4062c3 <.text+0x5e63>
               	jmp	0x406227 <.text+0x5dc7>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x7, %rax
               	jne	0x406309 <.text+0x5ea9>
               	movq	-0x38(%rbp), %r14
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	%rbx, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movq	(%rbx), %r15
               	shlq	$0x3, %r15
               	addq	%r15, %r14
               	movq	%r14, -0x38(%rbp)
               	jmp	0x406304 <.text+0x5ea4>
               	jmp	0x4062c3 <.text+0x5e63>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x8, %r14
               	jne	0x406363 <.text+0x5f03>
               	movq	-0x40(%rbp), %r15
               	movq	%r15, -0x38(%rbp)
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r14)
               	movq	(%r15), %r12
               	movq	%r12, -0x40(%rbp)
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movq	(%r12), %r14
               	movq	%r14, -0x30(%rbp)
               	jmp	0x40635e <.text+0x5efe>
               	jmp	0x406304 <.text+0x5ea4>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x9, %r14
               	jne	0x40638a <.text+0x5f2a>
               	movq	-0x48(%rbp), %r12
               	movq	(%r12), %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406385 <.text+0x5f25>
               	jmp	0x40635e <.text+0x5efe>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0xa, %r14
               	jne	0x4063b2 <.text+0x5f52>
               	movq	-0x48(%rbp), %r12
               	movzbq	(%r12), %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x4063ad <.text+0x5f4d>
               	jmp	0x406385 <.text+0x5f25>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0xb, %r14
               	jne	0x4063ed <.text+0x5f8d>
               	leaq	-0x38(%rbp), %r12
               	movq	(%r12), %r14
               	movq	%r14, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r12)
               	movq	(%r14), %r15
               	movq	-0x48(%rbp), %r14
               	movq	%r14, (%r15)
               	jmp	0x4063e8 <.text+0x5f88>
               	jmp	0x4063ad <.text+0x5f4d>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0xc, %r14
               	jne	0x40642b <.text+0x5fcb>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rbx)
               	movq	(%r14), %r12
               	movq	-0x48(%rbp), %r14
               	movb	%r14b, (%r12)
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406426 <.text+0x5fc6>
               	jmp	0x4063e8 <.text+0x5f88>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0xd, %r14
               	jne	0x40645e <.text+0x5ffe>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%r15)
               	movq	-0x48(%rbp), %r12
               	movq	%r12, (%r14)
               	jmp	0x406459 <.text+0x5ff9>
               	jmp	0x406426 <.text+0x5fc6>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0xe, %r12
               	jne	0x40649c <.text+0x603c>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	(%r12), %rbx
               	movq	-0x48(%rbp), %r12
               	orq	%r12, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x406497 <.text+0x6037>
               	jmp	0x406459 <.text+0x5ff9>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0xf, %rbx
               	jne	0x4064db <.text+0x607b>
               	leaq	-0x38(%rbp), %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	(%rbx), %r15
               	movq	-0x48(%rbp), %rbx
               	xorq	%rbx, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x4064d6 <.text+0x6076>
               	jmp	0x406497 <.text+0x6037>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x10, %r15
               	jne	0x406518 <.text+0x60b8>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %r12
               	movq	-0x48(%rbp), %r15
               	andq	%r15, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	0x406513 <.text+0x60b3>
               	jmp	0x4064d6 <.text+0x6076>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x11, %r12
               	jne	0x40655e <.text+0x60fe>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	(%r12), %rbx
               	movq	-0x48(%rbp), %r12
               	cmpq	%r12, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x406559 <.text+0x60f9>
               	jmp	0x406513 <.text+0x60b3>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x12, %rbx
               	jne	0x4065a5 <.text+0x6145>
               	leaq	-0x38(%rbp), %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	(%rbx), %r15
               	movq	-0x48(%rbp), %rbx
               	cmpq	%rbx, %r15
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x4065a0 <.text+0x6140>
               	jmp	0x406559 <.text+0x60f9>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x13, %r15
               	jne	0x4065ea <.text+0x618a>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %r12
               	movq	-0x48(%rbp), %r15
               	cmpq	%r15, %r12
               	setl	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	0x4065e5 <.text+0x6185>
               	jmp	0x4065a0 <.text+0x6140>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x14, %r12
               	jne	0x406630 <.text+0x61d0>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	(%r12), %rbx
               	movq	-0x48(%rbp), %r12
               	cmpq	%r12, %rbx
               	setg	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x40662b <.text+0x61cb>
               	jmp	0x4065e5 <.text+0x6185>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x15, %rbx
               	jne	0x406677 <.text+0x6217>
               	leaq	-0x38(%rbp), %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	(%rbx), %r15
               	movq	-0x48(%rbp), %rbx
               	cmpq	%rbx, %r15
               	setle	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x406672 <.text+0x6212>
               	jmp	0x40662b <.text+0x61cb>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x16, %r15
               	jne	0x4066bc <.text+0x625c>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %r12
               	movq	-0x48(%rbp), %r15
               	cmpq	%r15, %r12
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	0x4066b7 <.text+0x6257>
               	jmp	0x406672 <.text+0x6212>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x17, %r12
               	jne	0x4066fd <.text+0x629d>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	(%r12), %rbx
               	movq	-0x48(%rbp), %r12
               	movq	%r12, %rcx
               	shlq	%cl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x4066f8 <.text+0x6298>
               	jmp	0x4066b7 <.text+0x6257>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x18, %rbx
               	jne	0x40673f <.text+0x62df>
               	leaq	-0x38(%rbp), %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	(%rbx), %r15
               	movq	-0x48(%rbp), %rbx
               	movq	%rbx, %rcx
               	sarq	%cl, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x40673a <.text+0x62da>
               	jmp	0x4066f8 <.text+0x6298>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x19, %r15
               	jne	0x40677c <.text+0x631c>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %r12
               	movq	-0x48(%rbp), %r15
               	addq	%r15, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	0x406777 <.text+0x6317>
               	jmp	0x40673a <.text+0x62da>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x1a, %r12
               	jne	0x4067ba <.text+0x635a>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	(%r12), %rbx
               	movq	-0x48(%rbp), %r12
               	subq	%r12, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x4067b5 <.text+0x6355>
               	jmp	0x406777 <.text+0x6317>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x1b, %rbx
               	jne	0x4067fa <.text+0x639a>
               	leaq	-0x38(%rbp), %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	(%rbx), %r15
               	movq	-0x48(%rbp), %rbx
               	imulq	%rbx, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x4067f5 <.text+0x6395>
               	jmp	0x4067b5 <.text+0x6355>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x1c, %r15
               	jne	0x406846 <.text+0x63e6>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %r12
               	movq	-0x48(%rbp), %r15
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r12, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%r12, -0x48(%rbp)
               	jmp	0x406841 <.text+0x63e1>
               	jmp	0x4067f5 <.text+0x6395>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x1d, %r12
               	jne	0x406893 <.text+0x6433>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	(%r12), %rbx
               	movq	-0x48(%rbp), %r12
               	movq	%r12, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rax
               	cqto
               	idivq	%r11
               	movq	%rdx, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x40688e <.text+0x642e>
               	jmp	0x406841 <.text+0x63e1>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x1e, %rbx
               	jne	0x4068d7 <.text+0x6477>
               	movq	-0x38(%rbp), %r12
               	movq	%r12, %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %r15
               	movq	(%r12), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x406d3f <open>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x4068d2 <.text+0x6472>
               	jmp	0x40688e <.text+0x642e>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1f, %rax
               	jne	0x40692a <.text+0x64ca>
               	movq	-0x38(%rbp), %r14
               	movq	%r14, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r12
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r15
               	movq	(%r14), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x406d51 <read>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406925 <.text+0x64c5>
               	jmp	0x4068d2 <.text+0x6472>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x20, %rax
               	jne	0x40695d <.text+0x64fd>
               	movq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x406d57 <close>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406958 <.text+0x64f8>
               	jmp	0x406925 <.text+0x64c5>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x21, %rax
               	jne	0x406a19 <.text+0x65b9>
               	movq	-0x38(%rbp), %r14
               	movq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r15
               	shlq	$0x3, %r15
               	addq	%r15, %r14
               	movq	%r14, -0x60(%rbp)
               	movq	-0x60(%rbp), %r15
               	movq	%r15, %r14
               	addq	$-0x8, %r14
               	movq	(%r14), %rbx
               	movq	%r15, %r14
               	addq	$-0x10, %r14
               	movq	(%r14), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r15, %r14
               	addq	$-0x18, %r14
               	movq	(%r14), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	%r15, %r14
               	addq	$-0x20, %r14
               	movq	(%r14), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%r15, %r14
               	addq	$-0x28, %r14
               	movq	(%r14), %r12
               	addq	$-0x30, %r15
               	movq	(%r15), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %r9
               	movq	%r12, %r8
               	movq	0x38(%rsp), %rsi
               	movq	0x30(%rsp), %rdx
               	movq	0x28(%rsp), %rcx
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406a14 <.text+0x65b4>
               	jmp	0x406958 <.text+0x64f8>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x22, %rax
               	jne	0x406a49 <.text+0x65e9>
               	movq	-0x38(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x406d45 <malloc>
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406a44 <.text+0x65e4>
               	jmp	0x406a14 <.text+0x65b4>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x23, %rax
               	jne	0x406a78 <.text+0x6618>
               	movq	-0x38(%rbp), %r15
               	movq	(%r15), %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x406d5d <free>
               	movslq	%eax, %rax
               	jmp	0x406a73 <.text+0x6613>
               	jmp	0x406a44 <.text+0x65e4>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x24, %r14
               	jne	0x406ac8 <.text+0x6668>
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %r14
               	addq	$0x10, %r14
               	movq	(%r14), %r15
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	(%r14), %r12
               	movq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x406d4b <memset>
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406ac3 <.text+0x6663>
               	jmp	0x406a73 <.text+0x6613>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x25, %rax
               	jne	0x406b1b <.text+0x66bb>
               	movq	-0x38(%rbp), %rbx
               	movq	%rbx, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r14
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
               	movq	(%rbx), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x406d33 <memcmp>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406b16 <.text+0x66b6>
               	jmp	0x406ac3 <.text+0x6663>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x26, %rax
               	jne	0x406b8a <.text+0x672a>
               	leaq	0x9d4e(%rip), %rbx      # 0x410881
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %r15
               	movq	-0x50(%rbp), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	jmp	0x406b16 <.text+0x66b6>
               	leaq	0x9d05(%rip), %r14      # 0x410896
               	movq	-0x58(%rbp), %rbx
               	movq	-0x50(%rbp), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x406d2d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
