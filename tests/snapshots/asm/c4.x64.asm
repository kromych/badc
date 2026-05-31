
c4.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x404e78 <.text+0x4a18>
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
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x4004eb <.text+0x8b>
               	leaq	0xfc7a(%rip), %rdi      # 0x410138
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
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
               	leaq	0xfc57(%rip), %rdi      # 0x410150
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfc45(%rip), %rsi      # 0x410156
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfc34(%rip), %r9       # 0x41015d
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x407387 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40057c <.text+0x11c>
               	leaq	0xfbd4(%rip), %r14      # 0x410138
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40057c <.text+0x11c>
               	leaq	0xfbb5(%rip), %r12      # 0x410138
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
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
               	jmp	0x4005d3 <.text+0x173>
               	leaq	0xfbe6(%rip), %r11      # 0x4101c0
               	leaq	0xfba7(%rip), %r9       # 0x410188
               	movq	(%r9), %r8
               	movzbq	(%r8), %r9
               	movq	%r9, (%r11)
               	cmpq	$0x0, %r9
               	je	0x40062b <.text+0x1cb>
               	leaq	0xfb89(%rip), %r8       # 0x410188
               	movq	(%r8), %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movq	%r11, (%r8)
               	leaq	0xfbaa(%rip), %r9       # 0x4101c0
               	movq	(%r9), %r11
               	cmpq	$0xa, %r11
               	jne	0x400671 <.text+0x211>
               	jmp	0x400650 <.text+0x1f0>
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
               	leaq	0xfb91(%rip), %r11      # 0x4101e8
               	movq	(%r11), %r9
               	cmpq	$0x0, %r9
               	je	0x400702 <.text+0x2a2>
               	jmp	0x40068d <.text+0x22d>
               	jmp	0x4005d3 <.text+0x173>
               	leaq	0xfb48(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x23, %r15
               	jne	0x400809 <.text+0x3a9>
               	jmp	0x4007ff <.text+0x39f>
               	leaq	0xfb64(%rip), %rbx      # 0x4101f8
               	leaq	0xfb45(%rip), %r9       # 0x4101e0
               	movq	(%r9), %r12
               	leaq	0xfae3(%rip), %r10      # 0x410188
               	movq	%r10, 0x20(%rsp)
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rdi
               	leaq	0xfad7(%rip), %r10      # 0x410190
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
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rdx
               	movq	0x28(%rsp), %r11
               	movq	%rdx, (%r11)
               	jmp	0x400720 <.text+0x2c0>
               	leaq	0xfad7(%rip), %r12      # 0x4101e0
               	movq	(%r12), %r15
               	movq	%r15, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r12)
               	jmp	0x40066c <.text+0x20c>
               	leaq	0xfa81(%rip), %rdx      # 0x4101a8
               	movq	(%rdx), %r14
               	leaq	0xfa6f(%rip), %rdx      # 0x4101a0
               	movq	(%rdx), %r15
               	cmpq	%r15, %r14
               	jge	0x4007a0 <.text+0x340>
               	leaq	0xfabd(%rip), %rbx      # 0x410201
               	leaq	0xfabc(%rip), %rdx      # 0x410207
               	leaq	0xfa56(%rip), %r15      # 0x4101a8
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	(%r14), %r12
               	movl	$0x5, %r14d
               	imulq	%r12, %r14
               	movq	%rdx, %r12
               	addq	%r14, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movq	(%r15), %r14
               	movq	(%r14), %r15
               	cmpq	$0x7, %r15
               	jg	0x4007e3 <.text+0x383>
               	jmp	0x4007a5 <.text+0x345>
               	jmp	0x400702 <.text+0x2a2>
               	leaq	0xfb1f(%rip), %rbx      # 0x4102cb
               	leaq	0xf9f5(%rip), %r14      # 0x4101a8
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movq	(%r15), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x4007de <.text+0x37e>
               	jmp	0x400720 <.text+0x2c0>
               	leaq	0xfae6(%rip), %r12      # 0x4102d0
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x4007de <.text+0x37e>
               	jmp	0x400839 <.text+0x3d9>
               	jmp	0x40066c <.text+0x20c>
               	leaq	0xf9b0(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x61, %r15
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	cmpq	$0x0, %r12
               	je	0x400905 <.text+0x4a5>
               	jmp	0x4008e3 <.text+0x483>
               	leaq	0xf948(%rip), %r15      # 0x410188
               	movq	(%r15), %rbx
               	movzbq	(%rbx), %r15
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r15, %rbx
               	cmpq	$0x0, %rbx
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x30(%rbp)
               	cmpq	$0x0, %r15
               	je	0x4008cd <.text+0x46d>
               	jmp	0x400895 <.text+0x435>
               	leaq	0xf90d(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rbx)
               	jmp	0x400839 <.text+0x3d9>
               	jmp	0x400804 <.text+0x3a4>
               	leaq	0xf8ec(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r15
               	movzbq	(%r15), %rbx
               	movq	%rbx, %r15
               	xorq	$0xa, %r15
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r15, %rbx
               	cmpq	$0x0, %rbx
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x30(%rbp)
               	jmp	0x4008cd <.text+0x46d>
               	movq	-0x30(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x400890 <.text+0x430>
               	jmp	0x400874 <.text+0x414>
               	leaq	0xf8d6(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x7a, %r12
               	setle	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x400905 <.text+0x4a5>
               	movq	-0x48(%rbp), %r15
               	movq	%r15, -0x40(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x40094a <.text+0x4ea>
               	leaq	0xf89f(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x41, %r15
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x50(%rbp)
               	cmpq	$0x0, %r12
               	je	0x400986 <.text+0x526>
               	jmp	0x400964 <.text+0x504>
               	movq	-0x40(%rbp), %r15
               	movq	%r15, -0x38(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x4009b6 <.text+0x556>
               	jmp	0x400993 <.text+0x533>
               	leaq	0xf855(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x5a, %r12
               	setle	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x50(%rbp)
               	jmp	0x400986 <.text+0x526>
               	movq	-0x50(%rbp), %r15
               	movq	%r15, -0x40(%rbp)
               	jmp	0x40094a <.text+0x4ea>
               	leaq	0xf826(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x5f, %r15
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x38(%rbp)
               	jmp	0x4009b6 <.text+0x556>
               	movq	-0x38(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x4009e5 <.text+0x585>
               	leaq	0xf7ba(%rip), %r15      # 0x410188
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	subq	$0x1, %r14
               	jmp	0x400a17 <.text+0x5b7>
               	jmp	0x400804 <.text+0x3a4>
               	leaq	0xf7d4(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r12
               	cmpq	$0x30, %r12
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x90(%rbp)
               	cmpq	$0x0, %rbx
               	je	0x400e0e <.text+0x9ae>
               	jmp	0x400de8 <.text+0x988>
               	leaq	0xf76a(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	movzbq	(%rbx), %r12
               	cmpq	$0x61, %r12
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x70(%rbp)
               	cmpq	$0x0, %rbx
               	je	0x400af4 <.text+0x694>
               	jmp	0x400acd <.text+0x66d>
               	leaq	0xf76e(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rbx
               	movl	$0x93, %r15d
               	imulq	%rbx, %r15
               	leaq	0xf721(%rip), %rbx      # 0x410188
               	movq	(%rbx), %rdx
               	movq	%rdx, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rbx)
               	movzbq	(%rdx), %rcx
               	movq	%r15, %rdx
               	addq	%rcx, %rdx
               	movq	%rdx, (%r12)
               	jmp	0x400a17 <.text+0x5b7>
               	leaq	0xf72f(%rip), %rdx      # 0x4101c0
               	movq	(%rdx), %rcx
               	movq	%rcx, %r12
               	shlq	$0x6, %r12
               	leaq	0xf6e6(%rip), %rcx      # 0x410188
               	movq	(%rcx), %r15
               	movq	%r15, %rcx
               	subq	%r14, %rcx
               	movq	%r12, %r15
               	addq	%rcx, %r15
               	movq	%r15, (%rdx)
               	leaq	0xf6f5(%rip), %rcx      # 0x4101b0
               	leaq	0xf6f6(%rip), %r15      # 0x4101b8
               	movq	(%r15), %rdx
               	movq	%rdx, (%rcx)
               	jmp	0x400c5d <.text+0x7fd>
               	leaq	0xf6b4(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	movzbq	(%rbx), %r12
               	cmpq	$0x7a, %r12
               	setle	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x70(%rbp)
               	jmp	0x400af4 <.text+0x694>
               	movq	-0x70(%rbp), %rbx
               	movq	%rbx, -0x68(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x400b3d <.text+0x6dd>
               	leaq	0xf678(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	movzbq	(%rbx), %r12
               	cmpq	$0x41, %r12
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x78(%rbp)
               	cmpq	$0x0, %rbx
               	je	0x400b7e <.text+0x71e>
               	jmp	0x400b57 <.text+0x6f7>
               	movq	-0x68(%rbp), %rbx
               	movq	%rbx, -0x60(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x400bbf <.text+0x75f>
               	jmp	0x400b8b <.text+0x72b>
               	leaq	0xf62a(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	movzbq	(%rbx), %r12
               	cmpq	$0x5a, %r12
               	setle	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x78(%rbp)
               	jmp	0x400b7e <.text+0x71e>
               	movq	-0x78(%rbp), %rbx
               	movq	%rbx, -0x68(%rbp)
               	jmp	0x400b3d <.text+0x6dd>
               	leaq	0xf5f6(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	movzbq	(%rbx), %r12
               	cmpq	$0x30, %r12
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x80(%rbp)
               	cmpq	$0x0, %rbx
               	je	0x400c00 <.text+0x7a0>
               	jmp	0x400bd9 <.text+0x779>
               	movq	-0x60(%rbp), %rbx
               	movq	%rbx, -0x58(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x400c47 <.text+0x7e7>
               	jmp	0x400c0d <.text+0x7ad>
               	leaq	0xf5a8(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	movzbq	(%rbx), %r12
               	cmpq	$0x39, %r12
               	setle	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x80(%rbp)
               	jmp	0x400c00 <.text+0x7a0>
               	movq	-0x80(%rbp), %rbx
               	movq	%rbx, -0x60(%rbp)
               	jmp	0x400bbf <.text+0x75f>
               	leaq	0xf574(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	movzbq	(%rbx), %r12
               	movq	%r12, %rbx
               	xorq	$0x5f, %rbx
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	$0x0, %r12
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x58(%rbp)
               	jmp	0x400c47 <.text+0x7e7>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400a8a <.text+0x62a>
               	jmp	0x400a4b <.text+0x5eb>
               	leaq	0xf54c(%rip), %rdx      # 0x4101b0
               	movq	(%rdx), %r15
               	movq	(%r15), %rdx
               	cmpq	$0x0, %rdx
               	je	0x400cbc <.text+0x85c>
               	leaq	0xf542(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdx
               	leaq	0xf528(%rip), %r15      # 0x4101b0
               	movq	(%r15), %rcx
               	movq	%rcx, %r15
               	addq	$0x8, %r15
               	movq	(%r15), %rcx
               	cmpq	%rcx, %rdx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x88(%rbp)
               	cmpq	$0x0, %r15
               	je	0x400d7c <.text+0x91c>
               	jmp	0x400d24 <.text+0x8c4>
               	leaq	0xf4ed(%rip), %r12      # 0x4101b0
               	movq	(%r12), %r15
               	movq	%r15, %rbx
               	addq	$0x10, %rbx
               	movq	%r14, (%rbx)
               	movq	(%r12), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	leaq	0xf4d7(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	movq	%r14, (%rbx)
               	movq	(%r12), %rdx
               	xorq	%r12, %r12
               	movl	$0x85, %r14d
               	movq	%r14, (%rdx)
               	movq	%r14, (%r15)
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xf485(%rip), %rcx      # 0x4101b0
               	movq	(%rcx), %r15
               	movq	%r15, %rcx
               	addq	$0x10, %rcx
               	movq	(%rcx), %rbx
               	leaq	0xf446(%rip), %rcx      # 0x410188
               	movq	(%rcx), %rdx
               	movq	%rdx, %r15
               	subq	%r14, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x407393 <memcmp>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	cmpq	$0x0, %rdx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x88(%rbp)
               	jmp	0x400d7c <.text+0x91c>
               	movq	-0x88(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x400dcc <.text+0x96c>
               	leaq	0xf429(%rip), %rdx      # 0x4101c0
               	leaq	0xf412(%rip), %r15      # 0x4101b0
               	movq	(%r15), %rbx
               	xorq	%r15, %r15
               	movq	(%rbx), %r12
               	movq	%r12, (%rdx)
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xf3dd(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %r15
               	movq	%r15, %r12
               	addq	$0x48, %r12
               	movq	%r12, (%rbx)
               	jmp	0x400c5d <.text+0x7fd>
               	leaq	0xf3d1(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rbx
               	cmpq	$0x39, %rbx
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x90(%rbp)
               	jmp	0x400e0e <.text+0x9ae>
               	movq	-0x90(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400e58 <.text+0x9f8>
               	leaq	0xf39f(%rip), %rbx      # 0x4101c8
               	leaq	0xf390(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	movq	%r14, %r12
               	subq	$0x30, %r12
               	movq	%r12, (%rbx)
               	cmpq	$0x0, %r12
               	je	0x400eaf <.text+0xa4f>
               	jmp	0x400e74 <.text+0xa14>
               	jmp	0x4009e0 <.text+0x580>
               	leaq	0xf361(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x2f, %r14
               	jne	0x40135f <.text+0xeff>
               	jmp	0x401327 <.text+0xec7>
               	jmp	0x400ef7 <.text+0xa97>
               	leaq	0xf340(%rip), %r12      # 0x4101c0
               	movl	$0x80, %r15d
               	movq	%r15, (%r12)
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xf2d2(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movzbq	(%r15), %rdi
               	movq	%rdi, %r15
               	xorq	$0x78, %r15
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r15, %rdi
               	cmpq	$0x0, %rdi
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xa0(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x400ff9 <.text+0xb99>
               	jmp	0x400fbe <.text+0xb5e>
               	leaq	0xf28a(%rip), %r14      # 0x410188
               	movq	(%r14), %r12
               	movzbq	(%r12), %r14
               	cmpq	$0x30, %r14
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x98(%rbp)
               	cmpq	$0x0, %r12
               	je	0x400fa5 <.text+0xb45>
               	jmp	0x400f7b <.text+0xb1b>
               	leaq	0xf293(%rip), %r14      # 0x4101c8
               	movq	(%r14), %r12
               	movl	$0xa, %ebx
               	imulq	%r12, %rbx
               	leaq	0xf240(%rip), %r12      # 0x410188
               	movq	(%r12), %r15
               	movq	%r15, %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%r12)
               	movzbq	(%r15), %rdi
               	movq	%rbx, %r15
               	addq	%rdi, %r15
               	movq	%r15, %rdi
               	subq	$0x30, %rdi
               	movq	%rdi, (%r14)
               	jmp	0x400ef7 <.text+0xa97>
               	jmp	0x400e79 <.text+0xa19>
               	leaq	0xf206(%rip), %r14      # 0x410188
               	movq	(%r14), %r12
               	movzbq	(%r12), %r14
               	cmpq	$0x39, %r14
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x98(%rbp)
               	jmp	0x400fa5 <.text+0xb45>
               	movq	-0x98(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400f76 <.text+0xb16>
               	jmp	0x400f2e <.text+0xace>
               	leaq	0xf1c3(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movzbq	(%r15), %rdi
               	movq	%rdi, %r15
               	xorq	$0x58, %r15
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r15, %rdi
               	cmpq	$0x0, %rdi
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xa0(%rbp)
               	jmp	0x400ff9 <.text+0xb99>
               	movq	-0xa0(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x401017 <.text+0xbb7>
               	jmp	0x40101c <.text+0xbbc>
               	jmp	0x400e79 <.text+0xa19>
               	jmp	0x401266 <.text+0xe06>
               	leaq	0xf19d(%rip), %rdi      # 0x4101c0
               	leaq	0xf15e(%rip), %r15      # 0x410188
               	movq	(%r15), %r14
               	movq	%r14, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r15)
               	movzbq	(%rbx), %r14
               	movq	%r14, (%rdi)
               	movq	%r14, -0xa8(%rbp)
               	cmpq	$0x0, %r14
               	je	0x4010d1 <.text+0xc71>
               	jmp	0x40109f <.text+0xc3f>
               	leaq	0xf167(%rip), %rbx      # 0x4101c8
               	movq	(%rbx), %r14
               	movq	%r14, %rdi
               	shlq	$0x4, %rdi
               	leaq	0xf14e(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	movq	%r15, %rdx
               	andq	$0xf, %rdx
               	movq	%rdi, %r15
               	addq	%rdx, %r15
               	movq	(%r14), %rdx
               	cmpq	$0x41, %rdx
               	jl	0x401242 <.text+0xde2>
               	jmp	0x401231 <.text+0xdd1>
               	jmp	0x401012 <.text+0xbb2>
               	leaq	0xf11a(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x30, %r14
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xc0(%rbp)
               	cmpq	$0x0, %rbx
               	je	0x40110f <.text+0xcaf>
               	jmp	0x4010ea <.text+0xc8a>
               	movq	-0xa8(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x40109a <.text+0xc3a>
               	jmp	0x40105a <.text+0xbfa>
               	leaq	0xf0cf(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x39, %rbx
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xc0(%rbp)
               	jmp	0x40110f <.text+0xcaf>
               	movq	-0xc0(%rbp), %r14
               	movq	%r14, -0xb8(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x40115c <.text+0xcfc>
               	leaq	0xf08f(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x61, %r14
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xc8(%rbp)
               	cmpq	$0x0, %rbx
               	je	0x4011a1 <.text+0xd41>
               	jmp	0x40117c <.text+0xd1c>
               	movq	-0xb8(%rbp), %r14
               	movq	%r14, -0xb0(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x4011e6 <.text+0xd86>
               	jmp	0x4011b4 <.text+0xd54>
               	leaq	0xf03d(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x66, %rbx
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xc8(%rbp)
               	jmp	0x4011a1 <.text+0xd41>
               	movq	-0xc8(%rbp), %r14
               	movq	%r14, -0xb8(%rbp)
               	jmp	0x40115c <.text+0xcfc>
               	leaq	0xf005(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x41, %r14
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xd0(%rbp)
               	cmpq	$0x0, %rbx
               	je	0x40121e <.text+0xdbe>
               	jmp	0x4011f9 <.text+0xd99>
               	movq	-0xb0(%rbp), %r14
               	movq	%r14, -0xa8(%rbp)
               	jmp	0x4010d1 <.text+0xc71>
               	leaq	0xefc0(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x46, %rbx
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xd0(%rbp)
               	jmp	0x40121e <.text+0xdbe>
               	movq	-0xd0(%rbp), %r14
               	movq	%r14, -0xb0(%rbp)
               	jmp	0x4011e6 <.text+0xd86>
               	movl	$0x9, %edx
               	movq	%rdx, -0xd8(%rbp)
               	jmp	0x401251 <.text+0xdf1>
               	xorq	%rdx, %rdx
               	movq	%rdx, -0xd8(%rbp)
               	jmp	0x401251 <.text+0xdf1>
               	movq	-0xd8(%rbp), %rdx
               	movq	%r15, %r14
               	addq	%rdx, %r14
               	movq	%r14, (%rbx)
               	jmp	0x40101c <.text+0xbbc>
               	leaq	0xef1b(%rip), %r14      # 0x410188
               	movq	(%r14), %rdx
               	movzbq	(%rdx), %r14
               	cmpq	$0x30, %r14
               	setge	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xe0(%rbp)
               	cmpq	$0x0, %rdx
               	je	0x40130e <.text+0xeae>
               	jmp	0x4012e5 <.text+0xe85>
               	leaq	0xef25(%rip), %r14      # 0x4101c8
               	movq	(%r14), %rdx
               	movq	%rdx, %rbx
               	shlq	$0x3, %rbx
               	leaq	0xeed4(%rip), %rdx      # 0x410188
               	movq	(%rdx), %r15
               	movq	%r15, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rdx)
               	movzbq	(%r15), %r12
               	movq	%rbx, %r15
               	addq	%r12, %r15
               	movq	%r15, %r12
               	subq	$0x30, %r12
               	movq	%r12, (%r14)
               	jmp	0x401266 <.text+0xe06>
               	jmp	0x401012 <.text+0xbb2>
               	leaq	0xee9c(%rip), %r14      # 0x410188
               	movq	(%r14), %rdx
               	movzbq	(%rdx), %r14
               	cmpq	$0x37, %r14
               	setle	%dl
               	movzbq	%dl, %rdx
               	movq	%rdx, -0xe0(%rbp)
               	jmp	0x40130e <.text+0xeae>
               	movq	-0xe0(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	je	0x4012e0 <.text+0xe80>
               	jmp	0x40129c <.text+0xe3c>
               	leaq	0xee5a(%rip), %r14      # 0x410188
               	movq	(%r14), %r15
               	movzbq	(%r15), %r14
               	movq	%r14, %r15
               	xorq	$0x2f, %r15
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r15, %r14
               	cmpq	$0x0, %r14
               	jne	0x4013b3 <.text+0xf53>
               	jmp	0x401392 <.text+0xf32>
               	jmp	0x400e53 <.text+0x9f3>
               	leaq	0xee5a(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x27, %r15
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf0(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x4014c4 <.text+0x1064>
               	jmp	0x40149f <.text+0x103f>
               	leaq	0xedef(%rip), %r14      # 0x410188
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%r14)
               	jmp	0x4013e8 <.text+0xf88>
               	jmp	0x40135a <.text+0xefa>
               	leaq	0xee06(%rip), %r14      # 0x4101c0
               	movl	$0xa0, %r12d
               	movq	%r12, (%r14)
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
               	leaq	0xed99(%rip), %r12      # 0x410188
               	movq	(%r12), %r15
               	movzbq	(%r15), %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xe8(%rbp)
               	cmpq	$0x0, %r12
               	je	0x401486 <.text+0x1026>
               	jmp	0x401449 <.text+0xfe9>
               	leaq	0xed59(%rip), %r15      # 0x410188
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%r15)
               	jmp	0x4013e8 <.text+0xf88>
               	jmp	0x4013ae <.text+0xf4e>
               	leaq	0xed38(%rip), %r15      # 0x410188
               	movq	(%r15), %r12
               	movzbq	(%r12), %r15
               	movq	%r15, %r12
               	xorq	$0xa, %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xe8(%rbp)
               	jmp	0x401486 <.text+0x1026>
               	movq	-0xe8(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x401444 <.text+0xfe4>
               	jmp	0x401428 <.text+0xfc8>
               	leaq	0xed1a(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x22, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xf0(%rbp)
               	jmp	0x4014c4 <.text+0x1064>
               	movq	-0xf0(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x4014ed <.text+0x108d>
               	leaq	0xecb9(%rip), %r12      # 0x410198
               	movq	(%r12), %r15
               	jmp	0x401509 <.text+0x10a9>
               	jmp	0x40135a <.text+0xefa>
               	leaq	0xeccc(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdi
               	cmpq	$0x3d, %rdi
               	jne	0x40171b <.text+0x12bb>
               	jmp	0x4016e4 <.text+0x1284>
               	leaq	0xec78(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	movzbq	(%r14), %r12
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r12, %r14
               	cmpq	$0x0, %r14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf8(%rbp)
               	cmpq	$0x0, %r12
               	je	0x4015e8 <.text+0x1188>
               	jmp	0x4015b7 <.text+0x1157>
               	leaq	0xec78(%rip), %rbx      # 0x4101c8
               	leaq	0xec31(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	movq	%r14, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r12)
               	movzbq	(%r14), %rdx
               	movq	%rdx, (%rbx)
               	cmpq	$0x5c, %rdx
               	jne	0x401638 <.text+0x11d8>
               	jmp	0x401601 <.text+0x11a1>
               	leaq	0xebff(%rip), %r12      # 0x410188
               	movq	(%r12), %rdi
               	movq	%rdi, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r12)
               	leaq	0xec1e(%rip), %rdi      # 0x4101c0
               	movq	(%rdi), %rbx
               	cmpq	$0x22, %rbx
               	jne	0x4016d0 <.text+0x1270>
               	jmp	0x40169c <.text+0x123c>
               	leaq	0xebca(%rip), %r14      # 0x410188
               	movq	(%r14), %r12
               	movzbq	(%r12), %r14
               	leaq	0xebf3(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rbx
               	cmpq	%rbx, %r14
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf8(%rbp)
               	jmp	0x4015e8 <.text+0x1188>
               	movq	-0xf8(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x401582 <.text+0x1122>
               	jmp	0x401549 <.text+0x10e9>
               	leaq	0xebc0(%rip), %rdx      # 0x4101c8
               	leaq	0xeb79(%rip), %r14      # 0x410188
               	movq	(%r14), %rbx
               	movq	%rbx, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r14)
               	movzbq	(%rbx), %r12
               	movq	%r12, (%rdx)
               	cmpq	$0x6e, %r12
               	jne	0x401669 <.text+0x1209>
               	jmp	0x401654 <.text+0x11f4>
               	leaq	0xeb81(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rdx
               	cmpq	$0x22, %rdx
               	jne	0x401697 <.text+0x1237>
               	jmp	0x40166e <.text+0x120e>
               	leaq	0xeb6d(%rip), %r12      # 0x4101c8
               	movl	$0xa, %ebx
               	movq	%rbx, (%r12)
               	jmp	0x401669 <.text+0x1209>
               	jmp	0x401638 <.text+0x11d8>
               	leaq	0xeb23(%rip), %rdx      # 0x410198
               	movq	(%rdx), %rbx
               	movq	%rbx, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rdx)
               	leaq	0xeb3c(%rip), %rdi      # 0x4101c8
               	movq	(%rdi), %r12
               	movb	%r12b, (%rbx)
               	jmp	0x401697 <.text+0x1237>
               	jmp	0x401509 <.text+0x10a9>
               	leaq	0xeb25(%rip), %rbx      # 0x4101c8
               	movq	%r15, (%rbx)
               	jmp	0x4016ab <.text+0x124b>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xeae9(%rip), %rbx      # 0x4101c0
               	movl	$0x80, %edi
               	movq	%rdi, (%rbx)
               	jmp	0x4016ab <.text+0x124b>
               	leaq	0xea9d(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movzbq	(%r15), %rdi
               	movq	%rdi, %r15
               	xorq	$0x3d, %r15
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r15, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x401787 <.text+0x1327>
               	jmp	0x401737 <.text+0x12d7>
               	jmp	0x4014e8 <.text+0x1088>
               	leaq	0xea9e(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdi
               	cmpq	$0x2b, %rdi
               	jne	0x4017d2 <.text+0x1372>
               	jmp	0x40179b <.text+0x133b>
               	leaq	0xea4a(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movq	%r15, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%rdi)
               	leaq	0xea6b(%rip), %r15      # 0x4101c0
               	movl	$0x95, %ebx
               	movq	%rbx, (%r15)
               	jmp	0x401762 <.text+0x1302>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xea32(%rip), %rbx      # 0x4101c0
               	movl	$0x8e, %edi
               	movq	%rdi, (%rbx)
               	jmp	0x401762 <.text+0x1302>
               	leaq	0xe9e6(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movzbq	(%r15), %rdi
               	movq	%rdi, %r15
               	xorq	$0x2b, %r15
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r15, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x40183e <.text+0x13de>
               	jmp	0x4017ee <.text+0x138e>
               	jmp	0x401716 <.text+0x12b6>
               	leaq	0xe9e7(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdi
               	cmpq	$0x2d, %rdi
               	jne	0x401889 <.text+0x1429>
               	jmp	0x401852 <.text+0x13f2>
               	leaq	0xe993(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movq	%r15, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%rdi)
               	leaq	0xe9b4(%rip), %r15      # 0x4101c0
               	movl	$0xa2, %ebx
               	movq	%rbx, (%r15)
               	jmp	0x401819 <.text+0x13b9>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe97b(%rip), %rbx      # 0x4101c0
               	movl	$0x9d, %edi
               	movq	%rdi, (%rbx)
               	jmp	0x401819 <.text+0x13b9>
               	leaq	0xe92f(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movzbq	(%r15), %rdi
               	movq	%rdi, %r15
               	xorq	$0x2d, %r15
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r15, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x4018f5 <.text+0x1495>
               	jmp	0x4018a5 <.text+0x1445>
               	jmp	0x4017cd <.text+0x136d>
               	leaq	0xe930(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdi
               	cmpq	$0x21, %rdi
               	jne	0x401940 <.text+0x14e0>
               	jmp	0x401909 <.text+0x14a9>
               	leaq	0xe8dc(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movq	%r15, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%rdi)
               	leaq	0xe8fd(%rip), %r15      # 0x4101c0
               	movl	$0xa3, %ebx
               	movq	%rbx, (%r15)
               	jmp	0x4018d0 <.text+0x1470>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe8c4(%rip), %rbx      # 0x4101c0
               	movl	$0x9e, %edi
               	movq	%rdi, (%rbx)
               	jmp	0x4018d0 <.text+0x1470>
               	leaq	0xe878(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movzbq	(%r15), %rdi
               	movq	%rdi, %r15
               	xorq	$0x3d, %r15
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r15, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x401987 <.text+0x1527>
               	jmp	0x40195c <.text+0x14fc>
               	jmp	0x401884 <.text+0x1424>
               	leaq	0xe879(%rip), %rdi      # 0x4101c0
               	movq	(%rdi), %rbx
               	cmpq	$0x3c, %rbx
               	jne	0x4019e3 <.text+0x1583>
               	jmp	0x4019ac <.text+0x154c>
               	leaq	0xe825(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movq	%r15, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%rdi)
               	leaq	0xe846(%rip), %r15      # 0x4101c0
               	movl	$0x96, %ebx
               	movq	%rbx, (%r15)
               	jmp	0x401987 <.text+0x1527>
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
               	leaq	0xe7d5(%rip), %rbx      # 0x410188
               	movq	(%rbx), %rdi
               	movzbq	(%rdi), %rbx
               	movq	%rbx, %rdi
               	xorq	$0x3d, %rdi
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rdi, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401a50 <.text+0x15f0>
               	jmp	0x4019ff <.text+0x159f>
               	jmp	0x40193b <.text+0x14db>
               	leaq	0xe7d6(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x3e, %r15
               	jne	0x401afb <.text+0x169b>
               	jmp	0x401ac3 <.text+0x1663>
               	leaq	0xe782(%rip), %rbx      # 0x410188
               	movq	(%rbx), %rdi
               	movq	%rdi, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rbx)
               	leaq	0xe7a3(%rip), %rdi      # 0x4101c0
               	movl	$0x99, %r15d
               	movq	%r15, (%rdi)
               	jmp	0x401a2b <.text+0x15cb>
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
               	leaq	0xe731(%rip), %r15      # 0x410188
               	movq	(%r15), %rbx
               	movzbq	(%rbx), %r15
               	movq	%r15, %rbx
               	xorq	$0x3c, %rbx
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	$0x0, %r15
               	jne	0x401aae <.text+0x164e>
               	leaq	0xe703(%rip), %r15      # 0x410188
               	movq	(%r15), %rbx
               	movq	%rbx, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r15)
               	leaq	0xe724(%rip), %rbx      # 0x4101c0
               	movl	$0x9b, %edi
               	movq	%rdi, (%rbx)
               	jmp	0x401aa9 <.text+0x1649>
               	jmp	0x401a2b <.text+0x15cb>
               	leaq	0xe70b(%rip), %rdi      # 0x4101c0
               	movl	$0x97, %r15d
               	movq	%r15, (%rdi)
               	jmp	0x401aa9 <.text+0x1649>
               	leaq	0xe6be(%rip), %r15      # 0x410188
               	movq	(%r15), %rbx
               	movzbq	(%rbx), %r15
               	movq	%r15, %rbx
               	xorq	$0x3d, %rbx
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	$0x0, %r15
               	jne	0x401b67 <.text+0x1707>
               	jmp	0x401b17 <.text+0x16b7>
               	jmp	0x4019de <.text+0x157e>
               	leaq	0xe6be(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdi
               	cmpq	$0x7c, %rdi
               	jne	0x401c0f <.text+0x17af>
               	jmp	0x401bd8 <.text+0x1778>
               	leaq	0xe66a(%rip), %r15      # 0x410188
               	movq	(%r15), %rbx
               	movq	%rbx, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r15)
               	leaq	0xe68b(%rip), %rbx      # 0x4101c0
               	movl	$0x9a, %edi
               	movq	%rdi, (%rbx)
               	jmp	0x401b42 <.text+0x16e2>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe61a(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movzbq	(%r15), %rdi
               	movq	%rdi, %r15
               	xorq	$0x3e, %r15
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r15, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x401bc4 <.text+0x1764>
               	leaq	0xe5ed(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movq	%r15, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%rdi)
               	leaq	0xe60e(%rip), %r15      # 0x4101c0
               	movl	$0x9c, %ebx
               	movq	%rbx, (%r15)
               	jmp	0x401bbf <.text+0x175f>
               	jmp	0x401b42 <.text+0x16e2>
               	leaq	0xe5f5(%rip), %rbx      # 0x4101c0
               	movl	$0x98, %edi
               	movq	%rdi, (%rbx)
               	jmp	0x401bbf <.text+0x175f>
               	leaq	0xe5a9(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movzbq	(%r15), %rdi
               	movq	%rdi, %r15
               	xorq	$0x7c, %r15
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r15, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x401c7b <.text+0x181b>
               	jmp	0x401c2b <.text+0x17cb>
               	jmp	0x401af6 <.text+0x1696>
               	leaq	0xe5aa(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdi
               	cmpq	$0x26, %rdi
               	jne	0x401cc6 <.text+0x1866>
               	jmp	0x401c8f <.text+0x182f>
               	leaq	0xe556(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movq	%r15, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%rdi)
               	leaq	0xe577(%rip), %r15      # 0x4101c0
               	movl	$0x90, %ebx
               	movq	%rbx, (%r15)
               	jmp	0x401c56 <.text+0x17f6>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe53e(%rip), %rbx      # 0x4101c0
               	movl	$0x92, %edi
               	movq	%rdi, (%rbx)
               	jmp	0x401c56 <.text+0x17f6>
               	leaq	0xe4f2(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movzbq	(%r15), %rdi
               	movq	%rdi, %r15
               	xorq	$0x26, %r15
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r15, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x401d32 <.text+0x18d2>
               	jmp	0x401ce2 <.text+0x1882>
               	jmp	0x401c0a <.text+0x17aa>
               	leaq	0xe4f3(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdi
               	cmpq	$0x5e, %rdi
               	jne	0x401d80 <.text+0x1920>
               	jmp	0x401d46 <.text+0x18e6>
               	leaq	0xe49f(%rip), %rdi      # 0x410188
               	movq	(%rdi), %r15
               	movq	%r15, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%rdi)
               	leaq	0xe4c0(%rip), %r15      # 0x4101c0
               	movl	$0x91, %ebx
               	movq	%rbx, (%r15)
               	jmp	0x401d0d <.text+0x18ad>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe487(%rip), %rbx      # 0x4101c0
               	movl	$0x94, %edi
               	movq	%rdi, (%rbx)
               	jmp	0x401d0d <.text+0x18ad>
               	leaq	0xe473(%rip), %rdi      # 0x4101c0
               	movl	$0x93, %r15d
               	movq	%r15, (%rdi)
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
               	jmp	0x401cc1 <.text+0x1861>
               	leaq	0xe439(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	cmpq	$0x25, %rbx
               	jne	0x401dd1 <.text+0x1971>
               	leaq	0xe422(%rip), %rbx      # 0x4101c0
               	movl	$0xa1, %r15d
               	movq	%r15, (%rbx)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401d7b <.text+0x191b>
               	leaq	0xe3e8(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdi
               	cmpq	$0x2a, %rdi
               	jne	0x401e22 <.text+0x19c2>
               	leaq	0xe3d1(%rip), %rdi      # 0x4101c0
               	movl	$0x9f, %r15d
               	movq	%r15, (%rdi)
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
               	jmp	0x401dcc <.text+0x196c>
               	leaq	0xe397(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	cmpq	$0x5b, %rbx
               	jne	0x401e73 <.text+0x1a13>
               	leaq	0xe380(%rip), %rbx      # 0x4101c0
               	movl	$0xa4, %r15d
               	movq	%r15, (%rbx)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401e1d <.text+0x19bd>
               	leaq	0xe346(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdi
               	cmpq	$0x3f, %rdi
               	jne	0x401ec4 <.text+0x1a64>
               	leaq	0xe32f(%rip), %rdi      # 0x4101c0
               	movl	$0x8f, %r15d
               	movq	%r15, (%rdi)
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
               	jmp	0x401e6e <.text+0x1a0e>
               	leaq	0xe2f5(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	cmpq	$0x7e, %rbx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x138(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x401f16 <.text+0x1ab6>
               	leaq	0xe2c8(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x3b, %r15
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x138(%rbp)
               	jmp	0x401f16 <.text+0x1ab6>
               	movq	-0x138(%rbp), %rbx
               	movq	%rbx, -0x130(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x401f56 <.text+0x1af6>
               	leaq	0xe288(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	cmpq	$0x7b, %rbx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x130(%rbp)
               	jmp	0x401f56 <.text+0x1af6>
               	movq	-0x130(%rbp), %r15
               	movq	%r15, -0x128(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x401f96 <.text+0x1b36>
               	leaq	0xe248(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x7d, %r15
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x128(%rbp)
               	jmp	0x401f96 <.text+0x1b36>
               	movq	-0x128(%rbp), %rbx
               	movq	%rbx, -0x120(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x401fd6 <.text+0x1b76>
               	leaq	0xe208(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	cmpq	$0x28, %rbx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x120(%rbp)
               	jmp	0x401fd6 <.text+0x1b76>
               	movq	-0x120(%rbp), %r15
               	movq	%r15, -0x118(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x402016 <.text+0x1bb6>
               	leaq	0xe1c8(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x29, %r15
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x118(%rbp)
               	jmp	0x402016 <.text+0x1bb6>
               	movq	-0x118(%rbp), %rbx
               	movq	%rbx, -0x110(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x402056 <.text+0x1bf6>
               	leaq	0xe188(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	cmpq	$0x5d, %rbx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x110(%rbp)
               	jmp	0x402056 <.text+0x1bf6>
               	movq	-0x110(%rbp), %r15
               	movq	%r15, -0x108(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x402096 <.text+0x1c36>
               	leaq	0xe148(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x2c, %r15
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x108(%rbp)
               	jmp	0x402096 <.text+0x1c36>
               	movq	-0x108(%rbp), %rbx
               	movq	%rbx, -0x100(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x4020d6 <.text+0x1c76>
               	leaq	0xe108(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	cmpq	$0x3a, %rbx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x100(%rbp)
               	jmp	0x4020d6 <.text+0x1c76>
               	movq	-0x100(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x40210f <.text+0x1caf>
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
               	jmp	0x401ebf <.text+0x1a5f>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	0xe07f(%rip), %r9       # 0x4101c0
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	jne	0x402199 <.text+0x1d39>
               	leaq	0xe17a(%rip), %r12      # 0x4102d2
               	leaq	0xe081(%rip), %r9       # 0x4101e0
               	movq	(%r9), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	jmp	0x402194 <.text+0x1d34>
               	jmp	0x4033b5 <.text+0x2f55>
               	leaq	0xe020(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x80, %r14
               	jne	0x40220b <.text+0x1dab>
               	leaq	0xdfe9(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	movq	(%r14), %rsi
               	movq	%rsi, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	leaq	0xdfe0(%rip), %rsi      # 0x4101c8
               	movq	(%rsi), %r14
               	movq	%r14, (%r12)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rsi
               	leaq	0xdfd2(%rip), %rsi      # 0x4101d0
               	movq	%r15, (%rsi)
               	jmp	0x402206 <.text+0x1da6>
               	jmp	0x402194 <.text+0x1d34>
               	leaq	0xdfae(%rip), %rsi      # 0x4101c0
               	movq	(%rsi), %r14
               	cmpq	$0x22, %r14
               	jne	0x402271 <.text+0x1e11>
               	leaq	0xdf77(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rsi
               	movq	%rsi, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x1, %esi
               	movq	%rsi, (%r15)
               	movq	(%r14), %r12
               	movq	%r12, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	leaq	0xdf70(%rip), %r12      # 0x4101c8
               	movq	(%r12), %r14
               	movq	%r14, (%rsi)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x40228e <.text+0x1e2e>
               	jmp	0x402206 <.text+0x1da6>
               	leaq	0xdf48(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x8c, %r15
               	jne	0x402311 <.text+0x1eb1>
               	jmp	0x4022e8 <.text+0x1e88>
               	leaq	0xdf2b(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x22, %r12
               	jne	0x4022b2 <.text+0x1e52>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x40228e <.text+0x1e2e>
               	leaq	0xdedf(%rip), %r15      # 0x410198
               	movq	(%r15), %r12
               	movq	%r12, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, %r12
               	andq	$-0x8, %r12
               	movq	%r12, (%r15)
               	leaq	0xdef6(%rip), %rsi      # 0x4101d0
               	movl	$0x2, %r12d
               	movq	%r12, (%rsi)
               	jmp	0x40226c <.text+0x1e0c>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xdec9(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x28, %r14
               	jne	0x402366 <.text+0x1f06>
               	jmp	0x40232d <.text+0x1ecd>
               	jmp	0x40226c <.text+0x1e0c>
               	leaq	0xdea8(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x85, %r15
               	jne	0x402553 <.text+0x20f3>
               	jmp	0x40251c <.text+0x20bc>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	jmp	0x40233a <.text+0x1eda>
               	leaq	0xde8f(%rip), %r15      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r15)
               	leaq	0xde6f(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x8a, %r12
               	jne	0x4023bb <.text+0x1f5b>
               	jmp	0x4023a9 <.text+0x1f49>
               	leaq	0xdf87(%rip), %r15      # 0x4102f4
               	leaq	0xde6c(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	0x40233a <.text+0x1eda>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x4023b6 <.text+0x1f56>
               	jmp	0x4023f2 <.text+0x1f92>
               	leaq	0xddfe(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x86, %r12
               	jne	0x4023ed <.text+0x1f8d>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	leaq	0xddef(%rip), %r12      # 0x4101d0
               	xorq	%r14, %r14
               	movq	%r14, (%r12)
               	jmp	0x4023ed <.text+0x1f8d>
               	jmp	0x4023b6 <.text+0x1f56>
               	leaq	0xddc7(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x9f, %r15
               	jne	0x40242d <.text+0x1fcd>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xddb8(%rip), %r15      # 0x4101d0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x2, %r14
               	movq	%r14, (%r15)
               	jmp	0x4023f2 <.text+0x1f92>
               	leaq	0xdd8c(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x29, %r12
               	jne	0x40249e <.text+0x203e>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x402451 <.text+0x1ff1>
               	leaq	0xdd48(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	movq	(%r14), %rsi
               	movq	%rsi, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	leaq	0xdd47(%rip), %rsi      # 0x4101d0
               	movq	(%rsi), %r14
               	cmpq	$0x0, %r14
               	jne	0x4024f1 <.text+0x2091>
               	jmp	0x4024e2 <.text+0x2082>
               	leaq	0xde72(%rip), %r14      # 0x410317
               	leaq	0xdd34(%rip), %r12      # 0x4101e0
               	movq	(%r12), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x402451 <.text+0x1ff1>
               	movl	$0x1, %r14d
               	movq	%r14, -0x30(%rbp)
               	jmp	0x402500 <.text+0x20a0>
               	movl	$0x8, %r14d
               	movq	%r14, -0x30(%rbp)
               	jmp	0x402500 <.text+0x20a0>
               	movq	-0x30(%rbp), %r14
               	movq	%r14, (%r15)
               	leaq	0xdcc2(%rip), %rsi      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%rsi)
               	jmp	0x40230c <.text+0x1eac>
               	leaq	0xdc8d(%rip), %r15      # 0x4101b0
               	movq	(%r15), %r14
               	movq	%r14, -0x10(%rbp)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xdc87(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x28, %r14
               	jne	0x402588 <.text+0x2128>
               	jmp	0x40256f <.text+0x210f>
               	jmp	0x40230c <.text+0x1eac>
               	leaq	0xdc66(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rsi
               	cmpq	$0x28, %rsi
               	jne	0x4029e9 <.text+0x2589>
               	jmp	0x4029ad <.text+0x254d>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	xorq	%r14, %r14
               	movq	%r14, -0x8(%rbp)
               	jmp	0x4025ab <.text+0x214b>
               	jmp	0x40254e <.text+0x20ee>
               	movq	-0x10(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x18, %r14
               	movq	(%r14), %r12
               	cmpq	$0x80, %r12
               	jne	0x402818 <.text+0x23b8>
               	jmp	0x4027ba <.text+0x235a>
               	leaq	0xdc0e(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x29, %r12
               	je	0x402623 <.text+0x21c3>
               	movl	$0x8e, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	leaq	0xdbc6(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r15
               	movq	%r15, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movl	$0xd, %r15d
               	movq	%r15, (%rsi)
               	leaq	-0x8(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, %rsi
               	addq	$0x1, %rsi
               	movq	%rsi, (%r14)
               	leaq	0xdbb2(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rsi
               	cmpq	$0x2c, %rsi
               	jne	0x40265b <.text+0x21fb>
               	jmp	0x40264e <.text+0x21ee>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	movq	-0x10(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x18, %r15
               	movq	(%r15), %r12
               	cmpq	$0x82, %r12
               	jne	0x4026a9 <.text+0x2249>
               	jmp	0x402660 <.text+0x2200>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	jmp	0x40265b <.text+0x21fb>
               	jmp	0x4025ab <.text+0x214b>
               	leaq	0xdb39(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	-0x10(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x28, %r12
               	movq	(%r12), %r15
               	movq	%r15, (%r14)
               	jmp	0x402693 <.text+0x2233>
               	movq	-0x8(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x40279a <.text+0x233a>
               	jmp	0x40275a <.text+0x22fa>
               	movq	-0x10(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x18, %r12
               	movq	(%r12), %r15
               	cmpq	$0x81, %r15
               	jne	0x402717 <.text+0x22b7>
               	leaq	0xdad1(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x3, %r12d
               	movq	%r12, (%r14)
               	movq	(%r15), %rsi
               	movq	%rsi, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movq	-0x10(%rbp), %rsi
               	movq	%rsi, %r15
               	addq	$0x28, %r15
               	movq	(%r15), %rsi
               	movq	%rsi, (%r12)
               	jmp	0x402712 <.text+0x22b2>
               	jmp	0x402693 <.text+0x2233>
               	leaq	0xdc1d(%rip), %r14      # 0x41033b
               	leaq	0xdabb(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	0x402712 <.text+0x22b2>
               	leaq	0xda3f(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x7, %r14d
               	movq	%r14, (%r15)
               	movq	(%r12), %rsi
               	movq	%rsi, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	-0x8(%rbp), %rsi
               	movq	%rsi, (%r14)
               	jmp	0x40279a <.text+0x233a>
               	leaq	0xda2f(%rip), %rsi      # 0x4101d0
               	movq	-0x10(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x20, %r14
               	movq	(%r14), %r12
               	movq	%r12, (%rsi)
               	jmp	0x402583 <.text+0x2123>
               	leaq	0xd9df(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r12)
               	movl	$0x1, %r14d
               	movq	%r14, (%rsi)
               	movq	(%r12), %r15
               	movq	%r15, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r12)
               	movq	-0x10(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x28, %r12
               	movq	(%r12), %r15
               	movq	%r15, (%rsi)
               	leaq	0xd9c6(%rip), %r12      # 0x4101d0
               	movq	%r14, (%r12)
               	jmp	0x402813 <.text+0x23b3>
               	jmp	0x402583 <.text+0x2123>
               	movq	-0x10(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x18, %r15
               	movq	(%r15), %r12
               	cmpq	$0x84, %r12
               	jne	0x4028d5 <.text+0x2475>
               	leaq	0xd963(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	xorq	%r15, %r15
               	movq	%r15, (%r14)
               	movq	(%r12), %rsi
               	movq	%rsi, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	leaq	0xd96a(%rip), %rsi      # 0x4101d8
               	movq	(%rsi), %r12
               	movq	-0x10(%rbp), %rsi
               	movq	%rsi, %r14
               	addq	$0x28, %r14
               	movq	(%r14), %rsi
               	movq	%r12, %r14
               	subq	%rsi, %r14
               	movq	%r14, (%r15)
               	jmp	0x402890 <.text+0x2430>
               	leaq	0xd909(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	leaq	0xd922(%rip), %r12      # 0x4101d0
               	movq	-0x10(%rbp), %r15
               	movq	%r15, %rsi
               	addq	$0x20, %rsi
               	movq	(%rsi), %r15
               	movq	%r15, (%r12)
               	cmpq	$0x0, %r15
               	jne	0x402992 <.text+0x2532>
               	jmp	0x402983 <.text+0x2523>
               	movq	-0x10(%rbp), %r14
               	movq	%r14, %rsi
               	addq	$0x18, %rsi
               	movq	(%rsi), %r14
               	cmpq	$0x83, %r14
               	jne	0x402940 <.text+0x24e0>
               	leaq	0xd8a6(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rsi
               	movq	%rsi, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x1, %esi
               	movq	%rsi, (%r15)
               	movq	(%r14), %r12
               	movq	%r12, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movq	-0x10(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x28, %r14
               	movq	(%r14), %r12
               	movq	%r12, (%rsi)
               	jmp	0x40293b <.text+0x24db>
               	jmp	0x402890 <.text+0x2430>
               	leaq	0xda0b(%rip), %r15      # 0x410352
               	leaq	0xd892(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	0x40293b <.text+0x24db>
               	movl	$0xa, %r15d
               	movq	%r15, -0x38(%rbp)
               	jmp	0x4029a1 <.text+0x2541>
               	movl	$0x9, %r15d
               	movq	%r15, -0x38(%rbp)
               	jmp	0x4029a1 <.text+0x2541>
               	movq	-0x38(%rbp), %r15
               	movq	%r15, (%r14)
               	jmp	0x402813 <.text+0x23b3>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rsi
               	leaq	0xd804(%rip), %rsi      # 0x4101c0
               	movq	(%rsi), %r12
               	cmpq	$0x8a, %r12
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x40(%rbp)
               	cmpq	$0x0, %rsi
               	jne	0x402a28 <.text+0x25c8>
               	jmp	0x402a05 <.text+0x25a5>
               	jmp	0x40254e <.text+0x20ee>
               	leaq	0xd7d0(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x9f, %r15
               	jne	0x402c0b <.text+0x27ab>
               	jmp	0x402bd0 <.text+0x2770>
               	leaq	0xd7b4(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rsi
               	cmpq	$0x86, %rsi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x40(%rbp)
               	jmp	0x402a28 <.text+0x25c8>
               	movq	-0x40(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x402a5a <.text+0x25fa>
               	leaq	0xd780(%rip), %rsi      # 0x4101c0
               	movq	(%rsi), %r12
               	cmpq	$0x8a, %r12
               	jne	0x402a96 <.text+0x2636>
               	jmp	0x402a87 <.text+0x2627>
               	jmp	0x4029e4 <.text+0x2584>
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	leaq	0xd74e(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x29, %r12
               	jne	0x402b8c <.text+0x272c>
               	jmp	0x402b7a <.text+0x271a>
               	movl	$0x1, %r12d
               	movq	%r12, -0x48(%rbp)
               	jmp	0x402aa2 <.text+0x2642>
               	xorq	%r12, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	0x402aa2 <.text+0x2642>
               	movq	-0x48(%rbp), %r12
               	movq	%r12, -0x8(%rbp)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rsi
               	jmp	0x402ab7 <.text+0x2657>
               	leaq	0xd702(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rsi
               	cmpq	$0x9f, %rsi
               	jne	0x402aee <.text+0x268e>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rsi
               	movq	-0x8(%rbp), %rsi
               	movq	%rsi, %r15
               	addq	$0x2, %r15
               	movq	%r15, -0x8(%rbp)
               	jmp	0x402ab7 <.text+0x2657>
               	leaq	0xd6cb(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rsi
               	cmpq	$0x29, %rsi
               	jne	0x402b37 <.text+0x26d7>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rsi
               	jmp	0x402b12 <.text+0x26b2>
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	leaq	0xd6a6(%rip), %r12      # 0x4101d0
               	movq	-0x8(%rbp), %r15
               	movq	%r15, (%r12)
               	jmp	0x402a55 <.text+0x25f5>
               	leaq	0xd82c(%rip), %r15      # 0x41036a
               	leaq	0xd69b(%rip), %rsi      # 0x4101e0
               	movq	(%rsi), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	0x402b12 <.text+0x26b2>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x402b87 <.text+0x2727>
               	jmp	0x402a55 <.text+0x25f5>
               	leaq	0xd7e5(%rip), %r14      # 0x410378
               	leaq	0xd646(%rip), %r12      # 0x4101e0
               	movq	(%r12), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x402b87 <.text+0x2727>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	leaq	0xd5e0(%rip), %r12      # 0x4101d0
               	movq	(%r12), %r14
               	cmpq	$0x1, %r14
               	jle	0x402c76 <.text+0x2816>
               	jmp	0x402c27 <.text+0x27c7>
               	jmp	0x4029e4 <.text+0x2584>
               	leaq	0xd5ae(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x94, %r15
               	jne	0x402d36 <.text+0x28d6>
               	jmp	0x402ce5 <.text+0x2885>
               	leaq	0xd5a2(%rip), %r14      # 0x4101d0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	subq	$0x2, %r15
               	movq	%r15, (%r14)
               	jmp	0x402c43 <.text+0x27e3>
               	leaq	0xd556(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	leaq	0xd56f(%rip), %r15      # 0x4101d0
               	movq	(%r15), %r14
               	cmpq	$0x0, %r14
               	jne	0x402cc9 <.text+0x2869>
               	jmp	0x402cba <.text+0x285a>
               	leaq	0xd715(%rip), %r14      # 0x410392
               	leaq	0xd55c(%rip), %r12      # 0x4101e0
               	movq	(%r12), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x402c43 <.text+0x27e3>
               	movl	$0xa, %r14d
               	movq	%r14, -0x50(%rbp)
               	jmp	0x402cd8 <.text+0x2878>
               	movl	$0x9, %r14d
               	movq	%r14, -0x50(%rbp)
               	jmp	0x402cd8 <.text+0x2878>
               	movq	-0x50(%rbp), %r14
               	movq	%r14, (%r12)
               	jmp	0x402c06 <.text+0x27a6>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	leaq	0xd49b(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	(%r14), %r12
               	cmpq	$0xa, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x58(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x402d78 <.text+0x2918>
               	jmp	0x402d52 <.text+0x28f2>
               	jmp	0x402c06 <.text+0x27a6>
               	leaq	0xd483(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x21, %r15
               	jne	0x402ea4 <.text+0x2a44>
               	jmp	0x402e08 <.text+0x29a8>
               	leaq	0xd447(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	(%r14), %r12
               	cmpq	$0x9, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x58(%rbp)
               	jmp	0x402d78 <.text+0x2918>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x402dc5 <.text+0x2965>
               	leaq	0xd410(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$-0x8, %r15
               	movq	%r15, (%r12)
               	jmp	0x402da7 <.text+0x2947>
               	leaq	0xd422(%rip), %r12      # 0x4101d0
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x2, %r14
               	movq	%r14, (%r12)
               	jmp	0x402d31 <.text+0x28d1>
               	leaq	0xd5db(%rip), %r12      # 0x4103a7
               	leaq	0xd40d(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x402da7 <.text+0x2947>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	leaq	0xd378(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movq	(%r12), %rsi
               	movq	%rsi, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1, %esi
               	movq	%rsi, (%r14)
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	xorq	%r15, %r15
               	movq	%r15, (%r14)
               	movq	(%r12), %rdx
               	movq	%rdx, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x11, %edx
               	movq	%rdx, (%r15)
               	leaq	0xd33a(%rip), %r12      # 0x4101d0
               	movq	%rsi, (%r12)
               	jmp	0x402e9f <.text+0x2a3f>
               	jmp	0x402d31 <.text+0x28d1>
               	leaq	0xd315(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rdx
               	cmpq	$0x7e, %rdx
               	jne	0x402f59 <.text+0x2af9>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rdx
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	leaq	0xd2c4(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%rsi)
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	movq	(%r14), %rsi
               	movq	%rsi, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movabsq	$-0x1, %rsi
               	movq	%rsi, (%r12)
               	movq	(%r14), %rdx
               	movq	%rdx, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movl	$0xf, %edx
               	movq	%rdx, (%rsi)
               	leaq	0xd284(%rip), %r14      # 0x4101d0
               	movq	%r15, (%r14)
               	jmp	0x402f54 <.text+0x2af4>
               	jmp	0x402e9f <.text+0x2a3f>
               	leaq	0xd260(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rdx
               	cmpq	$0x9d, %rdx
               	jne	0x402fa4 <.text+0x2b44>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rdx
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	leaq	0xd240(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	0x402f9f <.text+0x2b3f>
               	jmp	0x402f54 <.text+0x2af4>
               	leaq	0xd215(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x9e, %r15
               	jne	0x403004 <.text+0x2ba4>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xd1d6(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	leaq	0xd1d6(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x80, %r12
               	jne	0x403089 <.text+0x2c29>
               	jmp	0x403033 <.text+0x2bd3>
               	jmp	0x402f9f <.text+0x2b3f>
               	leaq	0xd1b5(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0xa2, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x60(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x403118 <.text+0x2cb8>
               	jmp	0x4030f5 <.text+0x2c95>
               	leaq	0xd166(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	leaq	0xd175(%rip), %r15      # 0x4101c8
               	movq	(%r15), %r12
               	movabsq	$-0x1, %r15
               	imulq	%r12, %r15
               	movq	%r15, (%r14)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x403074 <.text+0x2c14>
               	leaq	0xd155(%rip), %rsi      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%rsi)
               	jmp	0x402fff <.text+0x2b9f>
               	leaq	0xd110(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movabsq	$-0x1, %r12
               	movq	%r12, (%r15)
               	movq	(%r14), %rsi
               	movq	%rsi, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %esi
               	movq	%rsi, (%r12)
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %rsi
               	movq	(%r14), %rsi
               	movq	%rsi, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x1b, %esi
               	movq	%rsi, (%r12)
               	jmp	0x403074 <.text+0x2c14>
               	leaq	0xd0c4(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0xa3, %r14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x60(%rbp)
               	jmp	0x403118 <.text+0x2cb8>
               	movq	-0x60(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x403175 <.text+0x2d15>
               	leaq	0xd090(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	movq	%r12, -0x8(%rbp)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	leaq	0xd049(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	(%r15), %r12
               	cmpq	$0xa, %r12
               	jne	0x403256 <.text+0x2df6>
               	jmp	0x4031b9 <.text+0x2d59>
               	jmp	0x402fff <.text+0x2b9f>
               	leaq	0xd260(%rip), %r15      # 0x4103dc
               	leaq	0xd05d(%rip), %r12      # 0x4101e0
               	movq	(%r12), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	jmp	0x403170 <.text+0x2d10>
               	leaq	0xcfe0(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movl	$0xd, %esi
               	movq	%rsi, (%r15)
               	movq	(%r12), %r14
               	movq	%r14, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r12)
               	movl	$0xa, %r14d
               	movq	%r14, (%rsi)
               	jmp	0x4031ec <.text+0x2d8c>
               	leaq	0xcfad(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movq	(%r12), %rsi
               	movq	%rsi, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x1, %esi
               	movq	%rsi, (%r15)
               	movq	(%r12), %r14
               	movq	%r14, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r12)
               	leaq	0xcf8f(%rip), %r14      # 0x4101d0
               	movq	(%r14), %r12
               	cmpq	$0x2, %r12
               	jle	0x4032f9 <.text+0x2e99>
               	jmp	0x4032ea <.text+0x2e8a>
               	leaq	0xcf43(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	(%r12), %r14
               	cmpq	$0x9, %r14
               	jne	0x4032a7 <.text+0x2e47>
               	leaq	0xcf28(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movl	$0xd, %esi
               	movq	%rsi, (%r12)
               	movq	(%r14), %r15
               	movq	%r15, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movl	$0x9, %r15d
               	movq	%r15, (%rsi)
               	jmp	0x4032a2 <.text+0x2e42>
               	jmp	0x4031ec <.text+0x2d8c>
               	leaq	0xd10d(%rip), %r12      # 0x4103bb
               	leaq	0xcf2b(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x4032a2 <.text+0x2e42>
               	movl	$0x8, %r12d
               	movq	%r12, -0x68(%rbp)
               	jmp	0x403308 <.text+0x2ea8>
               	movl	$0x1, %r12d
               	movq	%r12, -0x68(%rbp)
               	jmp	0x403308 <.text+0x2ea8>
               	movq	-0x68(%rbp), %r12
               	movq	%r12, (%rsi)
               	leaq	0xce8a(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movq	-0x8(%rbp), %r12
               	cmpq	$0xa2, %r12
               	jne	0x403346 <.text+0x2ee6>
               	movl	$0x19, %r12d
               	movq	%r12, -0x70(%rbp)
               	jmp	0x403355 <.text+0x2ef5>
               	movl	$0x1a, %r12d
               	movq	%r12, -0x70(%rbp)
               	jmp	0x403355 <.text+0x2ef5>
               	movq	-0x70(%rbp), %r12
               	movq	%r12, (%rsi)
               	leaq	0xce3d(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	leaq	0xce56(%rip), %r12      # 0x4101d0
               	movq	(%r12), %r14
               	cmpq	$0x0, %r14
               	jne	0x40339a <.text+0x2f3a>
               	movl	$0xc, %r14d
               	movq	%r14, -0x78(%rbp)
               	jmp	0x4033a9 <.text+0x2f49>
               	movl	$0xb, %r14d
               	movq	%r14, -0x78(%rbp)
               	jmp	0x4033a9 <.text+0x2f49>
               	movq	-0x78(%rbp), %r14
               	movq	%r14, (%rsi)
               	jmp	0x403170 <.text+0x2d10>
               	leaq	0xce04(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	movq	0x28(%rsp), %r10
               	cmpq	%r10, %r14
               	jl	0x4033f7 <.text+0x2f97>
               	leaq	0xcdfc(%rip), %r14      # 0x4101d0
               	movq	(%r14), %r15
               	movq	%r15, -0x8(%rbp)
               	leaq	0xcdde(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x8e, %r15
               	jne	0x40345c <.text+0x2ffc>
               	jmp	0x40341c <.text+0x2fbc>
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
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xcd75(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	(%r12), %r15
               	cmpq	$0xa, %r15
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x80(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x40349e <.text+0x303e>
               	jmp	0x403478 <.text+0x3018>
               	jmp	0x4033b5 <.text+0x2f55>
               	leaq	0xcd5d(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rsi
               	cmpq	$0x8f, %rsi
               	jne	0x4035f6 <.text+0x3196>
               	jmp	0x403587 <.text+0x3127>
               	leaq	0xcd21(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	(%r12), %r15
               	cmpq	$0x9, %r15
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x80(%rbp)
               	jmp	0x40349e <.text+0x303e>
               	movq	-0x80(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x403510 <.text+0x30b0>
               	leaq	0xccea(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	jmp	0x4034c8 <.text+0x3068>
               	movl	$0x8e, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r15
               	leaq	0xccc0(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	leaq	0xccd9(%rip), %r14      # 0x4101d0
               	movq	-0x8(%rbp), %r15
               	movq	%r15, (%r14)
               	cmpq	$0x0, %r15
               	jne	0x403565 <.text+0x3105>
               	jmp	0x403553 <.text+0x30f3>
               	leaq	0xced9(%rip), %r12      # 0x4103f0
               	leaq	0xccc2(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x4034c8 <.text+0x3068>
               	movl	$0xc, %r15d
               	movq	%r15, -0x88(%rbp)
               	jmp	0x403577 <.text+0x3117>
               	movl	$0xb, %r15d
               	movq	%r15, -0x88(%rbp)
               	jmp	0x403577 <.text+0x3117>
               	movq	-0x88(%rbp), %r15
               	movq	%r15, (%r12)
               	jmp	0x403457 <.text+0x2ff7>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rsi
               	leaq	0xcc0a(%rip), %rsi      # 0x4101a0
               	movq	(%rsi), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rsi)
               	movl	$0x4, %r14d
               	movq	%r14, (%r12)
               	movq	(%rsi), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rsi)
               	movq	%r14, -0x10(%rbp)
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	leaq	0xcbe4(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x3a, %r12
               	jne	0x403698 <.text+0x3238>
               	jmp	0x403613 <.text+0x31b3>
               	jmp	0x403457 <.text+0x2ff7>
               	leaq	0xcbc3(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x90, %r15
               	jne	0x40375c <.text+0x32fc>
               	jmp	0x4036dc <.text+0x327c>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x403620 <.text+0x31c0>
               	movq	-0x10(%rbp), %r14
               	leaq	0xcb75(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %rsi
               	addq	$0x18, %rsi
               	movq	%rsi, (%r14)
               	movq	(%r12), %r15
               	movq	%r15, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, (%rsi)
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movq	%r15, -0x10(%rbp)
               	movl	$0x8f, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	movq	-0x10(%rbp), %r14
               	movq	(%r12), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	jmp	0x4035f1 <.text+0x3191>
               	leaq	0xcd6f(%rip), %r14      # 0x41040e
               	leaq	0xcb3a(%rip), %r12      # 0x4101e0
               	movq	(%r12), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x403620 <.text+0x31c0>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xcab5(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x5, %r14d
               	movq	%r14, (%r15)
               	movq	(%r12), %rsi
               	movq	%rsi, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	%r14, -0x10(%rbp)
               	movl	$0x91, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	movq	-0x10(%rbp), %r14
               	movq	(%r12), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	leaq	0xca87(%rip), %r15      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r15)
               	jmp	0x403757 <.text+0x32f7>
               	jmp	0x4035f1 <.text+0x3191>
               	leaq	0xca5d(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x91, %r14
               	jne	0x4037f4 <.text+0x3394>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	leaq	0xca1d(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x4, %r15d
               	movq	%r15, (%r14)
               	movq	(%r12), %rsi
               	movq	%rsi, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movq	%r15, -0x10(%rbp)
               	movl	$0x92, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r15
               	movq	-0x10(%rbp), %r15
               	movq	(%r12), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	leaq	0xc9ef(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	0x4037ef <.text+0x338f>
               	jmp	0x403757 <.text+0x32f7>
               	leaq	0xc9c5(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x92, %r15
               	jne	0x40387d <.text+0x341d>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc985(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movl	$0x93, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xe, %r14d
               	movq	%r14, (%r15)
               	leaq	0xc967(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	0x403878 <.text+0x3418>
               	jmp	0x4037ef <.text+0x338f>
               	leaq	0xc93c(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x93, %r15
               	jne	0x403900 <.text+0x34a0>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc8fd(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x94, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xf, %r12d
               	movq	%r12, (%r15)
               	leaq	0xc8e3(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	0x4038fb <.text+0x349b>
               	jmp	0x403878 <.text+0x3418>
               	leaq	0xc8b9(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x94, %r15
               	jne	0x403989 <.text+0x3529>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc879(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movl	$0x95, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x10, %r14d
               	movq	%r14, (%r15)
               	leaq	0xc85b(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	0x403984 <.text+0x3524>
               	jmp	0x4038fb <.text+0x349b>
               	leaq	0xc830(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x95, %r15
               	jne	0x403a0c <.text+0x35ac>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc7f1(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x97, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x11, %r12d
               	movq	%r12, (%r15)
               	leaq	0xc7d7(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	0x403a07 <.text+0x35a7>
               	jmp	0x403984 <.text+0x3524>
               	leaq	0xc7ad(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x96, %r15
               	jne	0x403a95 <.text+0x3635>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc76d(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movl	$0x97, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x12, %r14d
               	movq	%r14, (%r15)
               	leaq	0xc74f(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	0x403a90 <.text+0x3630>
               	jmp	0x403a07 <.text+0x35a7>
               	leaq	0xc724(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x97, %r15
               	jne	0x403b18 <.text+0x36b8>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc6e5(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x9b, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x13, %r12d
               	movq	%r12, (%r15)
               	leaq	0xc6cb(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	0x403b13 <.text+0x36b3>
               	jmp	0x403a90 <.text+0x3630>
               	leaq	0xc6a1(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x98, %r15
               	jne	0x403ba1 <.text+0x3741>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc661(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movl	$0x9b, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x14, %r14d
               	movq	%r14, (%r15)
               	leaq	0xc643(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	0x403b9c <.text+0x373c>
               	jmp	0x403b13 <.text+0x36b3>
               	leaq	0xc618(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x99, %r15
               	jne	0x403c24 <.text+0x37c4>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc5d9(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x9b, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x15, %r12d
               	movq	%r12, (%r15)
               	leaq	0xc5bf(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	0x403c1f <.text+0x37bf>
               	jmp	0x403b9c <.text+0x373c>
               	leaq	0xc595(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x9a, %r15
               	jne	0x403cad <.text+0x384d>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc555(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movl	$0x9b, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x16, %r14d
               	movq	%r14, (%r15)
               	leaq	0xc537(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	0x403ca8 <.text+0x3848>
               	jmp	0x403c1f <.text+0x37bf>
               	leaq	0xc50c(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x9b, %r15
               	jne	0x403d30 <.text+0x38d0>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc4cd(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x9d, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x17, %r12d
               	movq	%r12, (%r15)
               	leaq	0xc4b3(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r14)
               	jmp	0x403d2b <.text+0x38cb>
               	jmp	0x403ca8 <.text+0x3848>
               	leaq	0xc489(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x9c, %r15
               	jne	0x403db9 <.text+0x3959>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc449(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movl	$0x9d, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x18, %r14d
               	movq	%r14, (%r15)
               	leaq	0xc42b(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	jmp	0x403db4 <.text+0x3954>
               	jmp	0x403d2b <.text+0x38cb>
               	leaq	0xc400(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x9d, %r15
               	jne	0x403e2f <.text+0x39cf>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc3c1(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x9f, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	leaq	0xc3c0(%rip), %r12      # 0x4101d0
               	movq	-0x8(%rbp), %r14
               	movq	%r14, (%r12)
               	cmpq	$0x2, %r14
               	jle	0x403ebc <.text+0x3a5c>
               	jmp	0x403e4b <.text+0x39eb>
               	jmp	0x403db4 <.text+0x3954>
               	leaq	0xc38a(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x9e, %r15
               	jne	0x403f4c <.text+0x3aec>
               	jmp	0x403ee2 <.text+0x3a82>
               	leaq	0xc34e(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %r15d
               	movq	%r15, (%r12)
               	movq	(%r14), %rsi
               	movq	%rsi, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x1, %esi
               	movq	%rsi, (%r15)
               	movq	(%r14), %r12
               	movq	%r12, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movl	$0x8, %r12d
               	movq	%r12, (%rsi)
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x1b, %r15d
               	movq	%r15, (%r12)
               	jmp	0x403ebc <.text+0x3a5c>
               	leaq	0xc2dd(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x19, %r14d
               	movq	%r14, (%r12)
               	jmp	0x403e2a <.text+0x39ca>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xc2af(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x9f, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	movq	-0x8(%rbp), %r12
               	cmpq	$0x2, %r12
               	setg	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x90(%rbp)
               	cmpq	$0x0, %r14
               	je	0x403f8d <.text+0x3b2d>
               	jmp	0x403f68 <.text+0x3b08>
               	jmp	0x403e2a <.text+0x39ca>
               	leaq	0xc26d(%rip), %rdx      # 0x4101c0
               	movq	(%rdx), %r14
               	cmpq	$0x9f, %r14
               	jne	0x404179 <.text+0x3d19>
               	jmp	0x404108 <.text+0x3ca8>
               	movq	-0x8(%rbp), %r12
               	leaq	0xc25d(%rip), %r14      # 0x4101d0
               	movq	(%r14), %r15
               	cmpq	%r15, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x90(%rbp)
               	jmp	0x403f8d <.text+0x3b2d>
               	movq	-0x90(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x404038 <.text+0x3bd8>
               	leaq	0xc1f8(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x1a, %r14d
               	movq	%r14, (%r12)
               	movq	(%r15), %rsi
               	movq	%rsi, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %esi
               	movq	%rsi, (%r14)
               	movq	(%r15), %r12
               	movq	%r12, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r15)
               	movl	$0x1, %r12d
               	movq	%r12, (%rsi)
               	movq	(%r15), %r14
               	movq	%r14, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r15)
               	movl	$0x8, %r14d
               	movq	%r14, (%rsi)
               	movq	(%r15), %rdx
               	movq	%rdx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x1c, %edx
               	movq	%rdx, (%r14)
               	leaq	0xc1a5(%rip), %r15      # 0x4101d0
               	movq	%r12, (%r15)
               	jmp	0x404033 <.text+0x3bd3>
               	jmp	0x403f47 <.text+0x3ae7>
               	leaq	0xc191(%rip), %r15      # 0x4101d0
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, (%r15)
               	cmpq	$0x2, %rdx
               	jle	0x4040e3 <.text+0x3c83>
               	leaq	0xc146(%rip), %rdx      # 0x4101a0
               	movq	(%rdx), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rdx)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movq	(%rdx), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rdx)
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	movq	(%rdx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rdx)
               	movl	$0x8, %r15d
               	movq	%r15, (%r14)
               	movq	(%rdx), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rdx)
               	movl	$0x1b, %r12d
               	movq	%r12, (%r15)
               	movq	(%rdx), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rdx)
               	movl	$0x1a, %r14d
               	movq	%r14, (%r12)
               	jmp	0x4040de <.text+0x3c7e>
               	jmp	0x404033 <.text+0x3bd3>
               	leaq	0xc0b6(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rdx
               	movq	%rdx, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x1a, %edx
               	movq	%rdx, (%r12)
               	jmp	0x4040de <.text+0x3c7e>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	leaq	0xc089(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r15
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1b, %r15d
               	movq	%r15, (%r14)
               	leaq	0xc06b(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	jmp	0x404174 <.text+0x3d14>
               	jmp	0x403f47 <.text+0x3ae7>
               	leaq	0xc040(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0xa0, %r14
               	jne	0x4041fc <.text+0x3d9c>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	leaq	0xc001(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x1c, %r12d
               	movq	%r12, (%r14)
               	leaq	0xbfe7(%rip), %r15      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%r15)
               	jmp	0x4041f7 <.text+0x3d97>
               	jmp	0x404174 <.text+0x3d14>
               	leaq	0xbfbd(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0xa1, %r14
               	jne	0x404285 <.text+0x3e25>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	leaq	0xbf7d(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r15
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1d, %r15d
               	movq	%r15, (%r14)
               	leaq	0xbf5f(%rip), %r12      # 0x4101d0
               	movl	$0x1, %r15d
               	movq	%r15, (%r12)
               	jmp	0x404280 <.text+0x3e20>
               	jmp	0x4041f7 <.text+0x3d97>
               	leaq	0xbf34(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0xa2, %r14
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x98(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x4042d7 <.text+0x3e77>
               	leaq	0xbf07(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0xa3, %r15
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x98(%rbp)
               	jmp	0x4042d7 <.text+0x3e77>
               	movq	-0x98(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x40430f <.text+0x3eaf>
               	leaq	0xbeae(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	movq	(%r14), %r15
               	cmpq	$0xa, %r15
               	jne	0x4043c6 <.text+0x3f66>
               	jmp	0x40432b <.text+0x3ecb>
               	jmp	0x404280 <.text+0x3e20>
               	leaq	0xbeaa(%rip), %rdx      # 0x4101c0
               	movq	(%rdx), %r15
               	cmpq	$0xa4, %r15
               	jne	0x404694 <.text+0x4234>
               	jmp	0x404639 <.text+0x41d9>
               	leaq	0xbe6e(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movq	(%r15), %rdx
               	movq	%rdx, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0xa, %edx
               	movq	%rdx, (%r12)
               	jmp	0x40435c <.text+0x3efc>
               	leaq	0xbe3d(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movq	(%r12), %rdx
               	movq	%rdx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1, %edx
               	movq	%rdx, (%r14)
               	movq	(%r12), %r15
               	movq	%r15, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%r12)
               	leaq	0xbe1f(%rip), %r15      # 0x4101d0
               	movq	(%r15), %r12
               	cmpq	$0x2, %r12
               	jle	0x40446c <.text+0x400c>
               	jmp	0x40445a <.text+0x3ffa>
               	leaq	0xbdd3(%rip), %rdx      # 0x4101a0
               	movq	(%rdx), %r15
               	movq	(%r15), %rdx
               	cmpq	$0x9, %rdx
               	jne	0x404417 <.text+0x3fb7>
               	leaq	0xbdb9(%rip), %rdx      # 0x4101a0
               	movq	(%rdx), %r15
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movq	(%rdx), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rdx)
               	movl	$0x9, %r14d
               	movq	%r14, (%r12)
               	jmp	0x404412 <.text+0x3fb2>
               	jmp	0x40435c <.text+0x3efc>
               	leaq	0xc00f(%rip), %r15      # 0x41042d
               	leaq	0xbdbb(%rip), %rdx      # 0x4101e0
               	movq	(%rdx), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	jmp	0x404412 <.text+0x3fb2>
               	movl	$0x8, %r12d
               	movq	%r12, -0xa0(%rbp)
               	jmp	0x40447e <.text+0x401e>
               	movl	$0x1, %r12d
               	movq	%r12, -0xa0(%rbp)
               	jmp	0x40447e <.text+0x401e>
               	movq	-0xa0(%rbp), %r12
               	movq	%r12, (%rdx)
               	leaq	0xbd11(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%r15)
               	leaq	0xbd1a(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0xa2, %r15
               	jne	0x4044c9 <.text+0x4069>
               	movl	$0x19, %r15d
               	movq	%r15, -0xa8(%rbp)
               	jmp	0x4044db <.text+0x407b>
               	movl	$0x1a, %r15d
               	movq	%r15, -0xa8(%rbp)
               	jmp	0x4044db <.text+0x407b>
               	movq	-0xa8(%rbp), %r15
               	movq	%r15, (%rdx)
               	leaq	0xbcb4(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%r12)
               	leaq	0xbccb(%rip), %r15      # 0x4101d0
               	movq	(%r15), %r12
               	cmpq	$0x0, %r12
               	jne	0x404527 <.text+0x40c7>
               	movl	$0xc, %r12d
               	movq	%r12, -0xb0(%rbp)
               	jmp	0x404539 <.text+0x40d9>
               	movl	$0xb, %r12d
               	movq	%r12, -0xb0(%rbp)
               	jmp	0x404539 <.text+0x40d9>
               	movq	-0xb0(%rbp), %r12
               	movq	%r12, (%rdx)
               	leaq	0xbc56(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%rdx)
               	movq	(%r15), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	movq	(%r15), %rdx
               	movq	%rdx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	leaq	0xbc3c(%rip), %rdx      # 0x4101d0
               	movq	(%rdx), %r15
               	cmpq	$0x2, %r15
               	jle	0x4045b6 <.text+0x4156>
               	movl	$0x8, %r15d
               	movq	%r15, -0xb8(%rbp)
               	jmp	0x4045c8 <.text+0x4168>
               	movl	$0x1, %r15d
               	movq	%r15, -0xb8(%rbp)
               	jmp	0x4045c8 <.text+0x4168>
               	movq	-0xb8(%rbp), %r15
               	movq	%r15, (%r14)
               	leaq	0xbbc7(%rip), %rdx      # 0x4101a0
               	movq	(%rdx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rdx)
               	leaq	0xbbd0(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdx
               	cmpq	$0xa2, %rdx
               	jne	0x404611 <.text+0x41b1>
               	movl	$0x1a, %edx
               	movq	%rdx, -0xc0(%rbp)
               	jmp	0x404622 <.text+0x41c2>
               	movl	$0x19, %edx
               	movq	%rdx, -0xc0(%rbp)
               	jmp	0x404622 <.text+0x41c2>
               	movq	-0xc0(%rbp), %rdx
               	movq	%rdx, (%r14)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	jmp	0x40430a <.text+0x3eaa>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xbb58(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x8e, %r14d
               	movq	%r14, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	leaq	0xbb47(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x5d, %r14
               	jne	0x404707 <.text+0x42a7>
               	jmp	0x4046e4 <.text+0x4284>
               	jmp	0x40430a <.text+0x3eaa>
               	leaq	0xbdeb(%rip), %r15      # 0x410486
               	leaq	0xbb3e(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r12
               	leaq	0xbb14(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	jmp	0x40468f <.text+0x422f>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	jmp	0x4046f1 <.text+0x4291>
               	movq	-0x8(%rbp), %r12
               	cmpq	$0x2, %r12
               	jle	0x40481c <.text+0x43bc>
               	jmp	0x40474a <.text+0x42ea>
               	leaq	0xbd41(%rip), %r12      # 0x41044f
               	leaq	0xbacb(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x4046f1 <.text+0x4291>
               	leaq	0xba4f(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movq	(%r12), %rdx
               	movq	%rdx, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x1, %edx
               	movq	%rdx, (%r15)
               	movq	(%r12), %r14
               	movq	%r14, %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%r12)
               	movl	$0x8, %r14d
               	movq	%r14, (%rdx)
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1b, %r15d
               	movq	%r15, (%r14)
               	jmp	0x4047c1 <.text+0x4361>
               	leaq	0xb9d8(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x19, %r15d
               	movq	%r15, (%r12)
               	movq	(%r14), %rdx
               	movq	%rdx, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	leaq	0xb9d7(%rip), %rdx      # 0x4101d0
               	movq	-0x8(%rbp), %r14
               	movq	%r14, %r12
               	subq	$0x2, %r12
               	movq	%r12, (%rdx)
               	cmpq	$0x0, %r12
               	jne	0x404888 <.text+0x4428>
               	jmp	0x404876 <.text+0x4416>
               	movq	-0x8(%rbp), %r15
               	cmpq	$0x2, %r15
               	jge	0x404871 <.text+0x4411>
               	leaq	0xbc37(%rip), %r14      # 0x41046b
               	leaq	0xb9a5(%rip), %r12      # 0x4101e0
               	movq	(%r12), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x404871 <.text+0x4411>
               	jmp	0x4047c1 <.text+0x4361>
               	movl	$0xa, %r12d
               	movq	%r12, -0xc8(%rbp)
               	jmp	0x40489a <.text+0x443a>
               	movl	$0x9, %r12d
               	movq	%r12, -0xc8(%rbp)
               	jmp	0x40489a <.text+0x443a>
               	movq	-0xc8(%rbp), %r12
               	movq	%r12, (%r15)
               	jmp	0x40468f <.text+0x422f>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xb8f2(%rip), %r11      # 0x4101c0
               	movq	(%r11), %r9
               	cmpq	$0x89, %r9
               	jne	0x404927 <.text+0x44c7>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r9
               	leaq	0xb8d3(%rip), %r9       # 0x4101c0
               	movq	(%r9), %rbx
               	cmpq	$0x28, %rbx
               	jne	0x40497d <.text+0x451d>
               	jmp	0x404943 <.text+0x44e3>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xb892(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rdi
               	cmpq	$0x8d, %rdi
               	jne	0x404b28 <.text+0x46c8>
               	jmp	0x404ae7 <.text+0x4687>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rbx
               	jmp	0x404950 <.text+0x44f0>
               	movl	$0x8e, %ebx
               	movq	%rbx, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r12
               	leaq	0xb859(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rbx
               	cmpq	$0x29, %rbx
               	jne	0x404a26 <.text+0x45c6>
               	jmp	0x4049c0 <.text+0x4560>
               	leaq	0xbb1c(%rip), %r14      # 0x4104a0
               	leaq	0xb855(%rip), %rbx      # 0x4101e0
               	movq	(%rbx), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	0x404950 <.text+0x44f0>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rbx
               	jmp	0x4049cd <.text+0x456d>
               	leaq	0xb7cc(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x4, %r15d
               	movq	%r15, (%r12)
               	movq	(%r14), %rdi
               	movq	%rdi, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movq	%r15, -0x10(%rbp)
               	callq	0x4048a9 <.text+0x4449>
               	movq	%rax, %rdi
               	leaq	0xb7af(%rip), %rdi      # 0x4101c0
               	movq	(%rdi), %r15
               	cmpq	$0x87, %r15
               	jne	0x404ac7 <.text+0x4667>
               	jmp	0x404a69 <.text+0x4609>
               	leaq	0xba8c(%rip), %r12      # 0x4104b9
               	leaq	0xb7ac(%rip), %rbx      # 0x4101e0
               	movq	(%rbx), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x4049cd <.text+0x456d>
               	movq	-0x10(%rbp), %r15
               	leaq	0xb72c(%rip), %rdi      # 0x4101a0
               	movq	(%rdi), %r14
               	movq	%r14, %r12
               	addq	$0x18, %r12
               	movq	%r12, (%r15)
               	movq	(%rdi), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rdi)
               	movl	$0x2, %r14d
               	movq	%r14, (%r12)
               	movq	(%rdi), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rdi)
               	movq	%r14, -0x10(%rbp)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	callq	0x4048a9 <.text+0x4449>
               	movq	%rax, %r15
               	jmp	0x404ac7 <.text+0x4667>
               	movq	-0x10(%rbp), %r14
               	leaq	0xb6ce(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rdi
               	movq	%rdi, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	jmp	0x404902 <.text+0x44a2>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rdi
               	leaq	0xb6aa(%rip), %rdi      # 0x4101a0
               	movq	(%rdi), %rbx
               	movq	%rbx, %rdi
               	addq	$0x8, %rdi
               	movq	%rdi, -0x8(%rbp)
               	leaq	0xb6b2(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rdi
               	cmpq	$0x28, %rdi
               	jne	0x404b7f <.text+0x471f>
               	jmp	0x404b45 <.text+0x46e5>
               	jmp	0x404902 <.text+0x44a2>
               	leaq	0xb691(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x8b, %r15
               	jne	0x404cc9 <.text+0x4869>
               	jmp	0x404ca0 <.text+0x4840>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rdi
               	jmp	0x404b52 <.text+0x46f2>
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r15
               	leaq	0xb656(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x29, %r12
               	jne	0x404c5c <.text+0x47fc>
               	jmp	0x404bc2 <.text+0x4762>
               	leaq	0xb94d(%rip), %rbx      # 0x4104d3
               	leaq	0xb653(%rip), %rdi      # 0x4101e0
               	movq	(%rdi), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x404b52 <.text+0x46f2>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x404bcf <.text+0x476f>
               	leaq	0xb5ca(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x4, %r14d
               	movq	%r14, (%r15)
               	movq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	%r14, -0x10(%rbp)
               	callq	0x4048a9 <.text+0x4449>
               	movq	%rax, %rbx
               	movq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x2, %ebx
               	movq	%rbx, (%r14)
               	movq	(%r12), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r12)
               	movq	-0x8(%rbp), %r15
               	movq	%r15, (%rbx)
               	movq	-0x10(%rbp), %r14
               	movq	(%r12), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	jmp	0x404b23 <.text+0x46c3>
               	leaq	0xb889(%rip), %r15      # 0x4104ec
               	leaq	0xb576(%rip), %r12      # 0x4101e0
               	movq	(%r12), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movabsq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	jmp	0x404bcf <.text+0x476f>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xb511(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	cmpq	$0x3b, %rbx
               	je	0x404cfb <.text+0x489b>
               	jmp	0x404ce5 <.text+0x4885>
               	jmp	0x404b23 <.text+0x46c3>
               	leaq	0xb4f0(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x7b, %rbx
               	jne	0x404d9c <.text+0x493c>
               	jmp	0x404d8a <.text+0x492a>
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r15
               	jmp	0x404cfb <.text+0x489b>
               	leaq	0xb49e(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x8, %r15d
               	movq	%r15, (%r14)
               	leaq	0xb49c(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x3b, %r15
               	jne	0x404d47 <.text+0x48e7>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	jmp	0x404d42 <.text+0x48e2>
               	jmp	0x404cc4 <.text+0x4864>
               	leaq	0xb7b8(%rip), %r12      # 0x410506
               	leaq	0xb48b(%rip), %r15      # 0x4101e0
               	movq	(%r15), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	jmp	0x404d42 <.text+0x48e2>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rbx
               	jmp	0x404db8 <.text+0x4958>
               	jmp	0x404cc4 <.text+0x4864>
               	leaq	0xb41d(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x3b, %r14
               	jne	0x404dfb <.text+0x499b>
               	jmp	0x404de9 <.text+0x4989>
               	leaq	0xb401(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	cmpq	$0x7d, %rbx
               	je	0x404ddc <.text+0x497c>
               	callq	0x4048a9 <.text+0x4449>
               	movq	%rax, %r15
               	jmp	0x404db8 <.text+0x4958>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	jmp	0x404d97 <.text+0x4937>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	jmp	0x404df6 <.text+0x4996>
               	jmp	0x404d97 <.text+0x4937>
               	movl	$0x8e, %r15d
               	movq	%r15, %rdi
               	callq	0x402114 <.text+0x1cb4>
               	movq	%rax, %r14
               	leaq	0xb3ad(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x3b, %r15
               	jne	0x404e35 <.text+0x49d5>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	jmp	0x404e30 <.text+0x49d0>
               	jmp	0x404df6 <.text+0x4996>
               	leaq	0xb6e2(%rip), %r14      # 0x41051e
               	leaq	0xb39d(%rip), %r15      # 0x4101e0
               	movq	(%r15), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x407399 <exit>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	jmp	0x404e30 <.text+0x49d0>
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
               	movq	%r9, %r8
               	addq	$-0x1, %r8
               	movq	%r8, (%r11)
               	leaq	0x20(%rbp), %r9
               	movq	(%r9), %r8
               	movq	%r8, %r11
               	addq	$0x8, %r11
               	movq	%r11, (%r9)
               	movq	0x10(%rbp), %r8
               	cmpq	$0x0, %r8
               	setg	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa0(%rbp)
               	cmpq	$0x0, %r11
               	je	0x404f46 <.text+0x4ae6>
               	movq	0x20(%rbp), %r8
               	movq	(%r8), %r11
               	movzbq	(%r11), %r8
               	movq	%r8, %r11
               	xorq	$0x2d, %r11
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa0(%rbp)
               	jmp	0x404f46 <.text+0x4ae6>
               	movq	-0xa0(%rbp), %r11
               	movq	%r11, -0x98(%rbp)
               	cmpq	$0x0, %r11
               	je	0x404fa4 <.text+0x4b44>
               	movq	0x20(%rbp), %r8
               	movq	(%r8), %r11
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r11
               	movq	%r11, %r8
               	xorq	$0x73, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r8, %r11
               	cmpq	$0x0, %r11
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x98(%rbp)
               	jmp	0x404fa4 <.text+0x4b44>
               	movq	-0x98(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x404ff5 <.text+0x4b95>
               	leaq	0xb229(%rip), %r11      # 0x4101e8
               	movl	$0x1, %r8d
               	movq	%r8, (%r11)
               	leaq	0x10(%rbp), %r9
               	movq	(%r9), %r8
               	movq	%r8, %r11
               	addq	$-0x1, %r11
               	movq	%r11, (%r9)
               	leaq	0x20(%rbp), %r8
               	movq	(%r8), %r11
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	%r9, (%r8)
               	jmp	0x404ff5 <.text+0x4b95>
               	movq	0x10(%rbp), %r9
               	cmpq	$0x0, %r9
               	setg	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xb0(%rbp)
               	cmpq	$0x0, %r11
               	je	0x405055 <.text+0x4bf5>
               	movq	0x20(%rbp), %r9
               	movq	(%r9), %r11
               	movzbq	(%r11), %r9
               	movq	%r9, %r11
               	xorq	$0x2d, %r11
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xb0(%rbp)
               	jmp	0x405055 <.text+0x4bf5>
               	movq	-0xb0(%rbp), %r11
               	movq	%r11, -0xa8(%rbp)
               	cmpq	$0x0, %r11
               	je	0x4050b3 <.text+0x4c53>
               	movq	0x20(%rbp), %r9
               	movq	(%r9), %r11
               	movq	%r11, %r9
               	addq	$0x1, %r9
               	movzbq	(%r9), %r11
               	movq	%r11, %r9
               	xorq	$0x64, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r9, %r11
               	cmpq	$0x0, %r11
               	sete	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xa8(%rbp)
               	jmp	0x4050b3 <.text+0x4c53>
               	movq	-0xa8(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x405104 <.text+0x4ca4>
               	leaq	0xb122(%rip), %r11      # 0x4101f0
               	movl	$0x1, %r9d
               	movq	%r9, (%r11)
               	leaq	0x10(%rbp), %r8
               	movq	(%r8), %r9
               	movq	%r9, %r11
               	addq	$-0x1, %r11
               	movq	%r11, (%r8)
               	leaq	0x20(%rbp), %r9
               	movq	(%r9), %r11
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	movq	%r8, (%r9)
               	jmp	0x405104 <.text+0x4ca4>
               	movq	0x10(%rbp), %r8
               	cmpq	$0x1, %r8
               	jge	0x405163 <.text+0x4d03>
               	leaq	0xb41a(%rip), %rbx      # 0x410536
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r11
               	movabsq	$-0x1, %r11
               	movq	%r11, %rcx
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
               	callq	0x40739f <open>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	jge	0x4051e5 <.text+0x4d85>
               	leaq	0xb3c0(%rip), %r15      # 0x410554
               	movq	0x20(%rbp), %r14
               	movq	(%r14), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movabsq	$-0x1, %r14
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
               	movl	$0x40000, %r12d         # imm = 0x40000
               	movslq	%r12d, %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0xafbe(%rip), %r12      # 0x4101b8
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x4073a5 <malloc>
               	movq	%rax, %r14
               	movq	%r14, (%r12)
               	cmpq	$0x0, %r14
               	jne	0x40526d <.text+0x4e0d>
               	leaq	0xb347(%rip), %r12      # 0x410568
               	movq	%r12, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movabsq	$-0x1, %rsi
               	movq	%rsi, %rcx
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
               	leaq	0xaf34(%rip), %r14      # 0x4101a8
               	leaq	0xaf25(%rip), %r12      # 0x4101a0
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x4073a5 <malloc>
               	movq	%rax, %rsi
               	movq	%rsi, (%r12)
               	movq	%rsi, (%r14)
               	cmpq	$0x0, %rsi
               	jne	0x4052f1 <.text+0x4e91>
               	leaq	0xb2e5(%rip), %r12      # 0x41058a
               	movq	%r12, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	movabsq	$-0x1, %rdx
               	movq	%rdx, %rcx
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
               	leaq	0xaea0(%rip), %r14      # 0x410198
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x4073a5 <malloc>
               	movq	%rax, %rdx
               	movq	%rdx, (%r14)
               	cmpq	$0x0, %rdx
               	jne	0x40536a <.text+0x4f0a>
               	leaq	0xb28c(%rip), %r14      # 0x4105aa
               	movq	%r14, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movabsq	$-0x1, %r12
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
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x4073a5 <malloc>
               	movq	%rax, %r14
               	movq	%r14, -0x38(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x4053dd <.text+0x4f7d>
               	leaq	0xb239(%rip), %r14      # 0x4105ca
               	movq	%r14, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movabsq	$-0x1, %r12
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
               	leaq	0xadd4(%rip), %r14      # 0x4101b8
               	movq	(%r14), %r12
               	xorq	%r14, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	0x4073ab <memset>
               	movq	%rax, %rdx
               	leaq	0xad9a(%rip), %rdx      # 0x4101a0
               	movq	(%rdx), %r12
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	0x4073ab <memset>
               	movq	%rax, %rdx
               	leaq	0xad73(%rip), %rdx      # 0x410198
               	movq	(%rdx), %r12
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	0x4073ab <memset>
               	movq	%rax, %rdx
               	leaq	0xad44(%rip), %rdx      # 0x410188
               	leaq	0xb1a0(%rip), %r12      # 0x4105eb
               	movq	%r12, (%rdx)
               	movl	$0x86, %r14d
               	movq	%r14, -0x58(%rbp)
               	jmp	0x40545d <.text+0x4ffd>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x8d, %r14
               	jg	0x40549d <.text+0x503d>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	leaq	0xad33(%rip), %r14      # 0x4101b0
               	movq	(%r14), %r12
               	leaq	-0x58(%rbp), %r14
               	movq	(%r14), %rdx
               	movq	%rdx, %rsi
               	addq	$0x1, %rsi
               	movq	%rsi, (%r14)
               	movq	%rdx, (%r12)
               	jmp	0x40545d <.text+0x4ffd>
               	movl	$0x1e, %edx
               	movq	%rdx, -0x58(%rbp)
               	jmp	0x4054ab <.text+0x504b>
               	movq	-0x58(%rbp), %rdx
               	cmpq	$0x26, %rdx
               	jg	0x405522 <.text+0x50c2>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rdx
               	leaq	0xace5(%rip), %rdx      # 0x4101b0
               	movq	(%rdx), %r14
               	movq	%r14, %r12
               	addq	$0x18, %r12
               	movl	$0x82, %r14d
               	movq	%r14, (%r12)
               	movq	(%rdx), %rsi
               	movq	%rsi, %r14
               	addq	$0x20, %r14
               	movl	$0x1, %esi
               	movq	%rsi, (%r14)
               	movq	(%rdx), %r12
               	movq	%r12, %rdx
               	addq	$0x28, %rdx
               	leaq	-0x58(%rbp), %r12
               	movq	(%r12), %rsi
               	movq	%rsi, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%r12)
               	movq	%rsi, (%rdx)
               	jmp	0x4054ab <.text+0x504b>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rsi
               	leaq	0xac7f(%rip), %r14      # 0x4101b0
               	movq	(%r14), %r12
               	movl	$0x86, %edx
               	movq	%rdx, (%r12)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rsi
               	movq	(%r14), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	0xac3c(%rip), %r14      # 0x410190
               	leaq	0xac2d(%rip), %r15      # 0x410188
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x4073a5 <malloc>
               	movq	%rax, %rdx
               	movq	%rdx, (%r15)
               	movq	%rdx, (%r14)
               	cmpq	$0x0, %rdx
               	jne	0x4055d0 <.text+0x5170>
               	leaq	0xb0d1(%rip), %r15      # 0x410655
               	movq	%r15, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movabsq	$-0x1, %rsi
               	movq	%rsi, %rcx
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
               	leaq	0xabb1(%rip), %r15      # 0x410188
               	movq	(%r15), %r14
               	movq	0x48(%rsp), %r15
               	subq	$0x1, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4073b1 <read>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movq	%rsi, -0x58(%rbp)
               	cmpq	$0x0, %rsi
               	jg	0x405662 <.text+0x5202>
               	leaq	0xb063(%rip), %r14      # 0x410677
               	movq	-0x58(%rbp), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movabsq	$-0x1, %rsi
               	movq	%rsi, %rcx
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
               	leaq	0xab1f(%rip), %r15      # 0x410188
               	movq	(%r15), %rsi
               	movq	-0x58(%rbp), %r15
               	movq	%rsi, %r14
               	addq	%r15, %r14
               	xorq	%r15, %r15
               	movb	%r15b, (%r14)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4073b7 <close>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	leaq	0xab4d(%rip), %rsi      # 0x4101e0
               	movl	$0x1, %ebx
               	movq	%rbx, (%rsi)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	jmp	0x4056a8 <.text+0x5248>
               	leaq	0xab11(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x0, %r15
               	je	0x4056e4 <.text+0x5284>
               	movl	$0x1, %ebx
               	movq	%rbx, -0x10(%rbp)
               	leaq	0xaaf1(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	cmpq	$0x8a, %rbx
               	jne	0x40571b <.text+0x52bb>
               	jmp	0x405709 <.text+0x52a9>
               	movq	0x40(%rsp), %rbx
               	addq	$0x28, %rbx
               	movq	(%rbx), %r12
               	movq	%r12, -0x30(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x40648d <.text+0x602d>
               	jmp	0x40643f <.text+0x5fdf>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rbx
               	jmp	0x405716 <.text+0x52b6>
               	jmp	0x4059b2 <.text+0x5552>
               	leaq	0xaa9e(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x86, %rbx
               	jne	0x40574b <.text+0x52eb>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rbx
               	xorq	%rbx, %rbx
               	movq	%rbx, -0x10(%rbp)
               	jmp	0x405746 <.text+0x52e6>
               	jmp	0x405716 <.text+0x52b6>
               	leaq	0xaa6e(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x88, %r15
               	jne	0x405786 <.text+0x5326>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xaa4f(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x7b, %r14
               	je	0x405798 <.text+0x5338>
               	jmp	0x40578b <.text+0x532b>
               	jmp	0x405746 <.text+0x52e6>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	jmp	0x405798 <.text+0x5338>
               	leaq	0xaa21(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x7b, %r14
               	jne	0x4057c3 <.text+0x5363>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	xorq	%r14, %r14
               	movq	%r14, -0x58(%rbp)
               	jmp	0x4057c8 <.text+0x5368>
               	jmp	0x405786 <.text+0x5326>
               	leaq	0xa9f1(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x7d, %r15
               	je	0x4057fb <.text+0x539b>
               	leaq	0xa9da(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x85, %r14
               	je	0x405870 <.text+0x5410>
               	jmp	0x405808 <.text+0x53a8>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x4057c3 <.text+0x5363>
               	leaq	0xae7c(%rip), %rbx      # 0x41068b
               	leaq	0xa9ca(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r14
               	leaq	0xa9a0(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
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
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	leaq	0xa941(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rbx
               	cmpq	$0x8e, %rbx
               	jne	0x4058b4 <.text+0x5454>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rbx
               	leaq	0xa921(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x80, %r15
               	je	0x405985 <.text+0x5525>
               	jmp	0x40592a <.text+0x54ca>
               	leaq	0xa8f5(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %r15
               	movq	%r15, %r12
               	addq	$0x18, %r12
               	movl	$0x80, %r15d
               	movq	%r15, (%r12)
               	movq	(%rbx), %r14
               	movq	%r14, %r15
               	addq	$0x20, %r15
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	movq	(%rbx), %r12
               	movq	%r12, %rbx
               	addq	$0x28, %rbx
               	leaq	-0x58(%rbp), %r12
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%r12)
               	movq	%r14, (%rbx)
               	leaq	0xa8ab(%rip), %rsi      # 0x4101c0
               	movq	(%rsi), %r14
               	cmpq	$0x2c, %r14
               	jne	0x4059ad <.text+0x554d>
               	jmp	0x4059a0 <.text+0x5540>
               	leaq	0xad76(%rip), %r12      # 0x4106a7
               	leaq	0xa8a8(%rip), %rbx      # 0x4101e0
               	movq	(%rbx), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
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
               	leaq	0xa83c(%rip), %r15      # 0x4101c8
               	movq	(%r15), %rbx
               	movq	%rbx, -0x58(%rbp)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	jmp	0x4058b4 <.text+0x5454>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	jmp	0x4059ad <.text+0x554d>
               	jmp	0x4057c8 <.text+0x5368>
               	leaq	0xa807(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x3b, %r12
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xb8(%rbp)
               	cmpq	$0x0, %r15
               	je	0x405a24 <.text+0x55c4>
               	jmp	0x4059fe <.text+0x559e>
               	movq	-0x10(%rbp), %r15
               	movq	%r15, -0x18(%rbp)
               	jmp	0x405a3d <.text+0x55dd>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x4056a8 <.text+0x5248>
               	leaq	0xa7bb(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x7d, %r15
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xb8(%rbp)
               	jmp	0x405a24 <.text+0x55c4>
               	movq	-0xb8(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x4059f1 <.text+0x5591>
               	jmp	0x4059e4 <.text+0x5584>
               	leaq	0xa77c(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	cmpq	$0x9f, %r12
               	jne	0x405a73 <.text+0x5613>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	movq	-0x18(%rbp), %r12
               	movq	%r12, %r14
               	addq	$0x2, %r14
               	movq	%r14, -0x18(%rbp)
               	jmp	0x405a3d <.text+0x55dd>
               	leaq	0xa746(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x85, %r12
               	je	0x405ae5 <.text+0x5685>
               	leaq	0xac30(%rip), %r15      # 0x4106c1
               	leaq	0xa748(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movabsq	$-0x1, %r14
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
               	leaq	0xa6c4(%rip), %r12      # 0x4101b0
               	movq	(%r12), %r14
               	movq	%r14, %r12
               	addq	$0x18, %r12
               	movq	(%r12), %r14
               	cmpq	$0x0, %r14
               	je	0x405b66 <.text+0x5706>
               	leaq	0xabcb(%rip), %rbx      # 0x4106dd
               	leaq	0xa6c7(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
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
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	leaq	0xa63b(%rip), %r12      # 0x4101b0
               	movq	(%r12), %r15
               	movq	%r15, %r12
               	addq	$0x20, %r12
               	movq	-0x18(%rbp), %r15
               	movq	%r15, (%r12)
               	leaq	0xa62e(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x28, %r15
               	jne	0x405c13 <.text+0x57b3>
               	leaq	0xa607(%rip), %r15      # 0x4101b0
               	movq	(%r15), %rbx
               	movq	%rbx, %r12
               	addq	$0x18, %r12
               	movl	$0x81, %ebx
               	movq	%rbx, (%r12)
               	movq	(%r15), %r14
               	movq	%r14, %r15
               	addq	$0x28, %r15
               	leaq	0xa5cd(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rbx
               	xorq	%rbx, %rbx
               	movq	%rbx, -0x58(%rbp)
               	jmp	0x405c61 <.text+0x5801>
               	leaq	0xa5c2(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x2c, %r14
               	jne	0x40643a <.text+0x5fda>
               	jmp	0x40642d <.text+0x5fcd>
               	leaq	0xa596(%rip), %r12      # 0x4101b0
               	movq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x18, %r14
               	movl	$0x83, %ebx
               	movq	%rbx, (%r14)
               	movq	(%r12), %r15
               	movq	%r15, %r12
               	addq	$0x28, %r12
               	leaq	0xa553(%rip), %r15      # 0x410198
               	movq	(%r15), %rbx
               	movq	%rbx, (%r12)
               	movq	(%r15), %r14
               	movq	%r14, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	jmp	0x405bf7 <.text+0x5797>
               	leaq	0xa558(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x29, %r14
               	je	0x405c9e <.text+0x583e>
               	movl	$0x1, %r14d
               	movq	%r14, -0x18(%rbp)
               	leaq	0xa537(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x8a, %r14
               	jne	0x405cd4 <.text+0x5874>
               	jmp	0x405cc2 <.text+0x5862>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r15
               	leaq	0xa513(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	cmpq	$0x7b, %rbx
               	je	0x405f79 <.text+0x5b19>
               	jmp	0x405f1e <.text+0x5abe>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	jmp	0x405ccf <.text+0x586f>
               	jmp	0x405d05 <.text+0x58a5>
               	leaq	0xa4e5(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x86, %r14
               	jne	0x405d00 <.text+0x58a0>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	xorq	%r14, %r14
               	movq	%r14, -0x18(%rbp)
               	jmp	0x405d00 <.text+0x58a0>
               	jmp	0x405ccf <.text+0x586f>
               	leaq	0xa4b4(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x9f, %rbx
               	jne	0x405d3b <.text+0x58db>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rbx
               	movq	-0x18(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0x2, %r12
               	movq	%r12, -0x18(%rbp)
               	jmp	0x405d05 <.text+0x58a5>
               	leaq	0xa47e(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rbx
               	cmpq	$0x85, %rbx
               	je	0x405daf <.text+0x594f>
               	leaq	0xa9a4(%rip), %r14      # 0x4106fe
               	leaq	0xa47f(%rip), %r12      # 0x4101e0
               	movq	(%r12), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movabsq	$-0x1, %r12
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
               	leaq	0xa3fa(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %r12
               	movq	%r12, %rbx
               	addq	$0x18, %rbx
               	movq	(%rbx), %r12
               	cmpq	$0x84, %r12
               	jne	0x405e2e <.text+0x59ce>
               	leaq	0xa943(%rip), %r15      # 0x41071d
               	leaq	0xa3ff(%rip), %rbx      # 0x4101e0
               	movq	(%rbx), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
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
               	leaq	0xa37b(%rip), %r12      # 0x4101b0
               	movq	(%r12), %rbx
               	movq	%rbx, %r15
               	addq	$0x30, %r15
               	movq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x18, %r14
               	movq	(%r14), %rbx
               	movq	%rbx, (%r15)
               	movq	(%r12), %r14
               	movq	%r14, %rbx
               	addq	$0x18, %rbx
               	movl	$0x84, %r14d
               	movq	%r14, (%rbx)
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x38, %r14
               	movq	(%r12), %r15
               	movq	%r15, %rbx
               	addq	$0x20, %rbx
               	movq	(%rbx), %r15
               	movq	%r15, (%r14)
               	movq	(%r12), %rbx
               	movq	%rbx, %r15
               	addq	$0x20, %r15
               	movq	-0x18(%rbp), %rbx
               	movq	%rbx, (%r15)
               	movq	(%r12), %r14
               	movq	%r14, %rbx
               	addq	$0x40, %rbx
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x28, %r15
               	movq	(%r15), %r14
               	movq	%r14, (%rbx)
               	movq	(%r12), %r15
               	movq	%r15, %r12
               	addq	$0x28, %r12
               	leaq	-0x58(%rbp), %r15
               	movq	(%r15), %r14
               	movq	%r14, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r15)
               	movq	%r14, (%r12)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rsi
               	leaq	0xa2c4(%rip), %rsi      # 0x4101c0
               	movq	(%rsi), %r14
               	cmpq	$0x2c, %r14
               	jne	0x405f19 <.text+0x5ab9>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rbx
               	jmp	0x405f19 <.text+0x5ab9>
               	jmp	0x405c61 <.text+0x5801>
               	leaq	0xa81c(%rip), %r14      # 0x410741
               	leaq	0xa2b4(%rip), %r15      # 0x4101e0
               	movq	(%r15), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
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
               	leaq	0xa258(%rip), %rbx      # 0x4101d8
               	leaq	-0x58(%rbp), %r15
               	movq	(%r15), %r14
               	movq	%r14, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%r15)
               	movq	%r12, (%rbx)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	jmp	0x405fa4 <.text+0x5b44>
               	leaq	0xa215(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x8a, %r14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xc0(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x406069 <.text+0x5c09>
               	jmp	0x406044 <.text+0x5be4>
               	leaq	0xa1e2(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x8a, %r14
               	jne	0x406094 <.text+0x5c34>
               	jmp	0x406082 <.text+0x5c22>
               	leaq	0xa1a5(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rbx
               	movq	%rbx, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x6, %ebx
               	movq	%rbx, (%r15)
               	movq	(%r12), %r14
               	movq	%r14, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r12)
               	movq	-0x58(%rbp), %r14
               	leaq	0xa1a6(%rip), %r12      # 0x4101d8
               	movq	(%r12), %r15
               	movq	%r14, %r12
               	subq	%r15, %r12
               	movq	%r12, (%rbx)
               	jmp	0x4062fd <.text+0x5e9d>
               	leaq	0xa175(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x86, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xc0(%rbp)
               	jmp	0x406069 <.text+0x5c09>
               	movq	-0xc0(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x405ff4 <.text+0x5b94>
               	jmp	0x405fd7 <.text+0x5b77>
               	movl	$0x1, %r14d
               	movq	%r14, -0xc8(%rbp)
               	jmp	0x4060a3 <.text+0x5c43>
               	xorq	%r14, %r14
               	movq	%r14, -0xc8(%rbp)
               	jmp	0x4060a3 <.text+0x5c43>
               	movq	-0xc8(%rbp), %r14
               	movq	%r14, -0x10(%rbp)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x4060bb <.text+0x5c5b>
               	leaq	0xa0fe(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x3b, %r12
               	je	0x4060df <.text+0x5c7f>
               	movq	-0x10(%rbp), %r12
               	movq	%r12, -0x18(%rbp)
               	jmp	0x4060ec <.text+0x5c8c>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rbx
               	jmp	0x405fa4 <.text+0x5b44>
               	leaq	0xa0cd(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x9f, %r14
               	jne	0x406123 <.text+0x5cc3>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r14
               	movq	-0x18(%rbp), %r14
               	movq	%r14, %r15
               	addq	$0x2, %r15
               	movq	%r15, -0x18(%rbp)
               	jmp	0x4060ec <.text+0x5c8c>
               	leaq	0xa096(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x85, %r14
               	je	0x406195 <.text+0x5d35>
               	leaq	0xa61d(%rip), %r12      # 0x41075e
               	leaq	0xa098(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
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
               	leaq	0xa014(%rip), %r14      # 0x4101b0
               	movq	(%r14), %r15
               	movq	%r15, %r14
               	addq	$0x18, %r14
               	movq	(%r14), %r15
               	cmpq	$0x84, %r15
               	jne	0x406214 <.text+0x5db4>
               	leaq	0xa5b9(%rip), %rbx      # 0x410779
               	leaq	0xa019(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movabsq	$-0x1, %r14
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
               	leaq	0x9f95(%rip), %r15      # 0x4101b0
               	movq	(%r15), %r14
               	movq	%r14, %rbx
               	addq	$0x30, %rbx
               	movq	(%r15), %r14
               	movq	%r14, %r12
               	addq	$0x18, %r12
               	movq	(%r12), %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x18, %r14
               	movl	$0x84, %r12d
               	movq	%r12, (%r14)
               	movq	(%r15), %rbx
               	movq	%rbx, %r12
               	addq	$0x38, %r12
               	movq	(%r15), %rbx
               	movq	%rbx, %r14
               	addq	$0x20, %r14
               	movq	(%r14), %rbx
               	movq	%rbx, (%r12)
               	movq	(%r15), %r14
               	movq	%r14, %rbx
               	addq	$0x20, %rbx
               	movq	-0x18(%rbp), %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x40, %r14
               	movq	(%r15), %r12
               	movq	%r12, %rbx
               	addq	$0x28, %rbx
               	movq	(%rbx), %r12
               	movq	%r12, (%r14)
               	movq	(%r15), %rbx
               	movq	%rbx, %r15
               	addq	$0x28, %r15
               	leaq	-0x58(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rbx)
               	movq	%r14, (%r15)
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	leaq	0x9ee6(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x2c, %r14
               	jne	0x4062f8 <.text+0x5e98>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %r12
               	jmp	0x4062f8 <.text+0x5e98>
               	jmp	0x4060bb <.text+0x5c5b>
               	leaq	0x9ebc(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x7d, %r15
               	je	0x406322 <.text+0x5ec2>
               	callq	0x4048a9 <.text+0x4449>
               	movq	%rax, %r15
               	jmp	0x4062fd <.text+0x5e9d>
               	leaq	0x9e77(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r14)
               	movl	$0x8, %r15d
               	movq	%r15, (%rbx)
               	leaq	0x9e67(%rip), %r14      # 0x4101b0
               	leaq	0x9e68(%rip), %r15      # 0x4101b8
               	movq	(%r15), %rbx
               	movq	%rbx, (%r14)
               	jmp	0x40635b <.text+0x5efb>
               	leaq	0x9e4e(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %r15
               	movq	(%r15), %rbx
               	cmpq	$0x0, %rbx
               	je	0x40639e <.text+0x5f3e>
               	leaq	0x9e34(%rip), %r15      # 0x4101b0
               	movq	(%r15), %rbx
               	movq	%rbx, %r15
               	addq	$0x18, %r15
               	movq	(%r15), %rbx
               	cmpq	$0x84, %rbx
               	jne	0x406411 <.text+0x5fb1>
               	jmp	0x4063a3 <.text+0x5f43>
               	jmp	0x405bf7 <.text+0x5797>
               	leaq	0x9e06(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x18, %r14
               	movq	(%rbx), %r15
               	movq	%r15, %r12
               	addq	$0x30, %r12
               	movq	(%r12), %r15
               	movq	%r15, (%r14)
               	movq	(%rbx), %r12
               	movq	%r12, %r15
               	addq	$0x20, %r15
               	movq	(%rbx), %r12
               	movq	%r12, %r14
               	addq	$0x38, %r14
               	movq	(%r14), %r12
               	movq	%r12, (%r15)
               	movq	(%rbx), %r14
               	movq	%r14, %r12
               	addq	$0x28, %r12
               	movq	(%rbx), %r14
               	movq	%r14, %rbx
               	addq	$0x40, %rbx
               	movq	(%rbx), %r14
               	movq	%r14, (%r12)
               	jmp	0x406411 <.text+0x5fb1>
               	leaq	0x9d98(%rip), %r14      # 0x4101b0
               	movq	(%r14), %rbx
               	movq	%rbx, %r12
               	addq	$0x48, %r12
               	movq	%r12, (%r14)
               	jmp	0x40635b <.text+0x5efb>
               	callq	0x4005b0 <.text+0x150>
               	movq	%rax, %rbx
               	jmp	0x40643a <.text+0x5fda>
               	jmp	0x4059b2 <.text+0x5552>
               	leaq	0xa353(%rip), %r14      # 0x410799
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
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
               	leaq	0x9d54(%rip), %r14      # 0x4101e8
               	movq	(%r14), %rbx
               	cmpq	$0x0, %rbx
               	je	0x4064d4 <.text+0x6074>
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
               	movq	-0x38(%rbp), %rbx
               	movq	0x48(%rsp), %r10
               	movq	%rbx, %r14
               	addq	%r10, %r14
               	movq	%r14, -0x38(%rbp)
               	movq	%r14, -0x40(%rbp)
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r14
               	movq	%r14, %r15
               	addq	$-0x8, %r15
               	movq	%r15, (%rbx)
               	movl	$0x26, %r14d
               	movq	%r14, (%r15)
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r14
               	movq	%r14, %r15
               	addq	$-0x8, %r15
               	movq	%r15, (%rbx)
               	movl	$0xd, %r14d
               	movq	%r14, (%r15)
               	movq	-0x38(%rbp), %rbx
               	movq	%rbx, -0x60(%rbp)
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, %r15
               	addq	$-0x8, %r15
               	movq	%r15, (%r14)
               	movq	0x10(%rbp), %rbx
               	movq	%rbx, (%r15)
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, %r15
               	addq	$-0x8, %r15
               	movq	%r15, (%r14)
               	movq	0x20(%rbp), %rbx
               	movq	%rbx, (%r15)
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, %r15
               	addq	$-0x8, %r15
               	movq	%r15, (%r14)
               	movq	-0x60(%rbp), %rbx
               	movq	%rbx, (%r15)
               	xorq	%r14, %r14
               	movq	%r14, -0x50(%rbp)
               	jmp	0x40658a <.text+0x612a>
               	movl	$0x1, %r14d
               	cmpq	$0x0, %r14
               	je	0x4065e9 <.text+0x6189>
               	leaq	-0x30(%rbp), %rbx
               	movq	(%rbx), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rbx)
               	movq	(%r14), %r12
               	movq	%r12, -0x58(%rbp)
               	leaq	-0x50(%rbp), %r14
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%r14)
               	leaq	0x9c1d(%rip), %r12      # 0x4101f0
               	movq	(%r12), %r15
               	cmpq	$0x0, %r15
               	je	0x40666a <.text+0x620a>
               	jmp	0x406619 <.text+0x61b9>
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
               	leaq	0xa18d(%rip), %rbx      # 0x4107ad
               	movq	-0x50(%rbp), %r12
               	leaq	0xa18b(%rip), %r14      # 0x4107b6
               	movq	-0x58(%rbp), %r15
               	movl	$0x5, %esi
               	imulq	%r15, %rsi
               	movq	%r14, %r15
               	addq	%rsi, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x7, %rsi
               	jg	0x4066ab <.text+0x624b>
               	jmp	0x406680 <.text+0x6220>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x0, %r12
               	jne	0x4066fd <.text+0x629d>
               	jmp	0x4066c7 <.text+0x6267>
               	leaq	0xa1f3(%rip), %r14      # 0x41087a
               	movq	-0x30(%rbp), %r15
               	movq	(%r15), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x4066a6 <.text+0x6246>
               	jmp	0x40666a <.text+0x620a>
               	leaq	0xa1cd(%rip), %r12      # 0x41087f
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x4066a6 <.text+0x6246>
               	movq	-0x40(%rbp), %r12
               	leaq	-0x30(%rbp), %r15
               	movq	(%r15), %r14
               	movq	%r14, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movq	(%r14), %rsi
               	movq	%rsi, %r14
               	shlq	$0x3, %r14
               	movq	%r12, %rsi
               	addq	%r14, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	0x4066f8 <.text+0x6298>
               	jmp	0x40658a <.text+0x612a>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x1, %rsi
               	jne	0x406733 <.text+0x62d3>
               	leaq	-0x30(%rbp), %rsi
               	movq	(%rsi), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rsi)
               	movq	(%r14), %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x40672e <.text+0x62ce>
               	jmp	0x4066f8 <.text+0x6298>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x2, %rbx
               	jne	0x406759 <.text+0x62f9>
               	movq	-0x30(%rbp), %rbx
               	movq	(%rbx), %r14
               	movq	%r14, -0x30(%rbp)
               	jmp	0x406754 <.text+0x62f4>
               	jmp	0x40672e <.text+0x62ce>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x3, %r14
               	jne	0x4067a5 <.text+0x6345>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, %r12
               	addq	$-0x8, %r12
               	movq	%r12, (%r14)
               	movq	-0x30(%rbp), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	-0x30(%rbp), %rbx
               	movq	(%rbx), %r14
               	movq	%r14, -0x30(%rbp)
               	jmp	0x4067a0 <.text+0x6340>
               	jmp	0x406754 <.text+0x62f4>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x4, %r14
               	jne	0x4067d1 <.text+0x6371>
               	movq	-0x48(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x406801 <.text+0x63a1>
               	jmp	0x4067e7 <.text+0x6387>
               	jmp	0x4067a0 <.text+0x6340>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x5, %rbx
               	jne	0x40683f <.text+0x63df>
               	jmp	0x406824 <.text+0x63c4>
               	movq	-0x30(%rbp), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, -0xd0(%rbp)
               	jmp	0x406814 <.text+0x63b4>
               	movq	-0x30(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, -0xd0(%rbp)
               	jmp	0x406814 <.text+0x63b4>
               	movq	-0xd0(%rbp), %rbx
               	movq	%rbx, -0x30(%rbp)
               	jmp	0x4067cc <.text+0x636c>
               	movq	-0x48(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x406868 <.text+0x6408>
               	jmp	0x406855 <.text+0x63f5>
               	jmp	0x4067cc <.text+0x636c>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x6, %r14
               	jne	0x4068e9 <.text+0x6489>
               	jmp	0x406892 <.text+0x6432>
               	movq	-0x30(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, -0xd8(%rbp)
               	jmp	0x406882 <.text+0x6422>
               	movq	-0x30(%rbp), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, -0xd8(%rbp)
               	jmp	0x406882 <.text+0x6422>
               	movq	-0xd8(%rbp), %r14
               	movq	%r14, -0x30(%rbp)
               	jmp	0x40683a <.text+0x63da>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, %r12
               	addq	$-0x8, %r12
               	movq	%r12, (%r14)
               	movq	-0x40(%rbp), %rbx
               	movq	%rbx, (%r12)
               	movq	-0x38(%rbp), %r14
               	movq	%r14, -0x40(%rbp)
               	leaq	-0x30(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rbx)
               	movq	(%r12), %r15
               	movq	%r15, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %r15
               	subq	%r12, %r15
               	movq	%r15, -0x38(%rbp)
               	jmp	0x4068e4 <.text+0x6484>
               	jmp	0x40683a <.text+0x63da>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x7, %r15
               	jne	0x406932 <.text+0x64d2>
               	movq	-0x38(%rbp), %r15
               	leaq	-0x30(%rbp), %r12
               	movq	(%r12), %r14
               	movq	%r14, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r12)
               	movq	(%r14), %rbx
               	movq	%rbx, %r14
               	shlq	$0x3, %r14
               	movq	%r15, %rbx
               	addq	%r14, %rbx
               	movq	%rbx, -0x38(%rbp)
               	jmp	0x40692d <.text+0x64cd>
               	jmp	0x4068e4 <.text+0x6484>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x8, %rbx
               	jne	0x40698b <.text+0x652b>
               	movq	-0x40(%rbp), %rbx
               	movq	%rbx, -0x38(%rbp)
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movq	(%rbx), %rsi
               	movq	%rsi, -0x40(%rbp)
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rbx)
               	movq	(%rsi), %r14
               	movq	%r14, -0x30(%rbp)
               	jmp	0x406986 <.text+0x6526>
               	jmp	0x40692d <.text+0x64cd>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x9, %r14
               	jne	0x4069b1 <.text+0x6551>
               	movq	-0x48(%rbp), %r14
               	movq	(%r14), %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	0x4069ac <.text+0x654c>
               	jmp	0x406986 <.text+0x6526>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0xa, %rsi
               	jne	0x4069d8 <.text+0x6578>
               	movq	-0x48(%rbp), %rsi
               	movzbq	(%rsi), %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x4069d3 <.text+0x6573>
               	jmp	0x4069ac <.text+0x654c>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0xb, %r14
               	jne	0x406a11 <.text+0x65b1>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rsi
               	movq	%rsi, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movq	(%rsi), %rbx
               	movq	-0x48(%rbp), %rsi
               	movq	%rsi, (%rbx)
               	jmp	0x406a0c <.text+0x65ac>
               	jmp	0x4069d3 <.text+0x6573>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0xc, %rsi
               	jne	0x406a4e <.text+0x65ee>
               	leaq	-0x38(%rbp), %rsi
               	movq	(%rsi), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rsi)
               	movq	(%r15), %r14
               	movq	-0x48(%rbp), %r15
               	movb	%r15b, (%r14)
               	movq	%r15, -0x48(%rbp)
               	jmp	0x406a49 <.text+0x65e9>
               	jmp	0x406a0c <.text+0x65ac>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0xd, %r15
               	jne	0x406a84 <.text+0x6624>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rbx
               	movq	%rbx, %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%r15)
               	movq	-0x48(%rbp), %rbx
               	movq	%rbx, (%r14)
               	jmp	0x406a7f <.text+0x661f>
               	jmp	0x406a49 <.text+0x65e9>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0xe, %rbx
               	jne	0x406ac4 <.text+0x6664>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %rsi
               	movq	-0x48(%rbp), %r15
               	movq	%rsi, %r14
               	orq	%r15, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406abf <.text+0x665f>
               	jmp	0x406a7f <.text+0x661f>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0xf, %r14
               	jne	0x406b04 <.text+0x66a4>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movq	(%r15), %rbx
               	movq	-0x48(%rbp), %r15
               	movq	%rbx, %rsi
               	xorq	%r15, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	0x406aff <.text+0x669f>
               	jmp	0x406abf <.text+0x665f>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x10, %rsi
               	jne	0x406b44 <.text+0x66e4>
               	leaq	-0x38(%rbp), %rsi
               	movq	(%rsi), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rsi)
               	movq	(%r15), %r14
               	movq	-0x48(%rbp), %r15
               	movq	%r14, %rbx
               	andq	%r15, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x406b3f <.text+0x66df>
               	jmp	0x406aff <.text+0x669f>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x11, %rbx
               	jne	0x406b89 <.text+0x6729>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %rsi
               	movq	-0x48(%rbp), %r15
               	cmpq	%r15, %rsi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406b84 <.text+0x6724>
               	jmp	0x406b3f <.text+0x66df>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x12, %r14
               	jne	0x406bce <.text+0x676e>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movq	(%r15), %rbx
               	movq	-0x48(%rbp), %r15
               	cmpq	%r15, %rbx
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	0x406bc9 <.text+0x6769>
               	jmp	0x406b84 <.text+0x6724>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x13, %rsi
               	jne	0x406c13 <.text+0x67b3>
               	leaq	-0x38(%rbp), %rsi
               	movq	(%rsi), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rsi)
               	movq	(%r15), %r14
               	movq	-0x48(%rbp), %r15
               	cmpq	%r15, %r14
               	setl	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x406c0e <.text+0x67ae>
               	jmp	0x406bc9 <.text+0x6769>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x14, %rbx
               	jne	0x406c58 <.text+0x67f8>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %rsi
               	movq	-0x48(%rbp), %r15
               	cmpq	%r15, %rsi
               	setg	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406c53 <.text+0x67f3>
               	jmp	0x406c0e <.text+0x67ae>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x15, %r14
               	jne	0x406c9d <.text+0x683d>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movq	(%r15), %rbx
               	movq	-0x48(%rbp), %r15
               	cmpq	%r15, %rbx
               	setle	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	0x406c98 <.text+0x6838>
               	jmp	0x406c53 <.text+0x67f3>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x16, %rsi
               	jne	0x406ce2 <.text+0x6882>
               	leaq	-0x38(%rbp), %rsi
               	movq	(%rsi), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rsi)
               	movq	(%r15), %r14
               	movq	-0x48(%rbp), %r15
               	cmpq	%r15, %r14
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x406cdd <.text+0x687d>
               	jmp	0x406c98 <.text+0x6838>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x17, %rbx
               	jne	0x406d25 <.text+0x68c5>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %rsi
               	movq	-0x48(%rbp), %r15
               	movq	%rsi, %r14
               	movq	%r15, %rcx
               	shlq	%cl, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406d20 <.text+0x68c0>
               	jmp	0x406cdd <.text+0x687d>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x18, %r14
               	jne	0x406d68 <.text+0x6908>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movq	(%r15), %rbx
               	movq	-0x48(%rbp), %r15
               	movq	%rbx, %rsi
               	movq	%r15, %rcx
               	sarq	%cl, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	0x406d63 <.text+0x6903>
               	jmp	0x406d20 <.text+0x68c0>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x19, %rsi
               	jne	0x406da8 <.text+0x6948>
               	leaq	-0x38(%rbp), %rsi
               	movq	(%rsi), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rsi)
               	movq	(%r15), %r14
               	movq	-0x48(%rbp), %r15
               	movq	%r14, %rbx
               	addq	%r15, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x406da3 <.text+0x6943>
               	jmp	0x406d63 <.text+0x6903>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x1a, %rbx
               	jne	0x406de8 <.text+0x6988>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %rsi
               	movq	-0x48(%rbp), %r15
               	movq	%rsi, %r14
               	subq	%r15, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406de3 <.text+0x6983>
               	jmp	0x406da3 <.text+0x6943>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x1b, %r14
               	jne	0x406e29 <.text+0x69c9>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%r14)
               	movq	(%r15), %rbx
               	movq	-0x48(%rbp), %r15
               	movq	%rbx, %rsi
               	imulq	%r15, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	0x406e24 <.text+0x69c4>
               	jmp	0x406de3 <.text+0x6983>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x1c, %rsi
               	jne	0x406e75 <.text+0x6a15>
               	leaq	-0x38(%rbp), %rsi
               	movq	(%rsi), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rsi)
               	movq	(%r15), %r14
               	movq	-0x48(%rbp), %r15
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r14, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x406e70 <.text+0x6a10>
               	jmp	0x406e24 <.text+0x69c4>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x1d, %rbx
               	jne	0x406ec1 <.text+0x6a61>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%r15), %rsi
               	movq	-0x48(%rbp), %r15
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	movq	%rdx, %r14
               	popq	%rdx
               	popq	%rax
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406ebc <.text+0x6a5c>
               	jmp	0x406e70 <.text+0x6a10>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x1e, %r14
               	jne	0x406f07 <.text+0x6aa7>
               	movq	-0x38(%rbp), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r12
               	movq	(%r14), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40739f <open>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406f02 <.text+0x6aa2>
               	jmp	0x406ebc <.text+0x6a5c>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x1f, %r14
               	jne	0x406f5d <.text+0x6afd>
               	movq	-0x38(%rbp), %r14
               	movq	%r14, %rbx
               	addq	$0x10, %rbx
               	movq	(%rbx), %r15
               	movq	%r14, %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %r12
               	movq	(%r14), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4073b1 <read>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406f58 <.text+0x6af8>
               	jmp	0x406f02 <.text+0x6aa2>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x20, %r14
               	jne	0x406f93 <.text+0x6b33>
               	movq	-0x38(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x4073b7 <close>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406f8e <.text+0x6b2e>
               	jmp	0x406f58 <.text+0x6af8>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x21, %r14
               	jne	0x40705f <.text+0x6bff>
               	movq	-0x38(%rbp), %r14
               	movq	-0x30(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	(%r12), %r15
               	movq	%r15, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %r15
               	addq	%r12, %r15
               	movq	%r15, -0x60(%rbp)
               	movq	-0x60(%rbp), %r12
               	movq	%r12, %r15
               	addq	$-0x8, %r15
               	movq	(%r15), %rbx
               	movq	%r12, %r15
               	addq	$-0x10, %r15
               	movq	(%r15), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r12, %r15
               	addq	$-0x18, %r15
               	movq	(%r15), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	%r12, %r15
               	addq	$-0x20, %r15
               	movq	(%r15), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%r12, %r15
               	addq	$-0x28, %r15
               	movq	(%r15), %r14
               	movq	%r12, %r15
               	addq	$-0x30, %r15
               	movq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %r9
               	movq	%r14, %r8
               	movq	0x38(%rsp), %rsi
               	movq	0x30(%rsp), %rdx
               	movq	0x28(%rsp), %rcx
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x40705a <.text+0x6bfa>
               	jmp	0x406f8e <.text+0x6b2e>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x22, %r15
               	jne	0x407092 <.text+0x6c32>
               	movq	-0x38(%rbp), %r15
               	movq	(%r15), %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4073a5 <malloc>
               	movq	%rax, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x40708d <.text+0x6c2d>
               	jmp	0x40705a <.text+0x6bfa>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x23, %r15
               	jne	0x4070c4 <.text+0x6c64>
               	movq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4073bd <free>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	jmp	0x4070bf <.text+0x6c5f>
               	jmp	0x40708d <.text+0x6c2d>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x24, %r12
               	jne	0x407118 <.text+0x6cb8>
               	movq	-0x38(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x10, %r15
               	movq	(%r15), %rbx
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r14
               	movq	(%r12), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4073ab <memset>
               	movq	%rax, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	0x407113 <.text+0x6cb3>
               	jmp	0x4070bf <.text+0x6c5f>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x25, %r12
               	jne	0x40716f <.text+0x6d0f>
               	movq	-0x38(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x10, %r15
               	movq	(%r15), %rbx
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r14
               	movq	(%r12), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x407393 <memcmp>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	0x40716a <.text+0x6d0a>
               	jmp	0x407113 <.text+0x6cb3>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x26, %r12
               	jne	0x4071e1 <.text+0x6d81>
               	leaq	0x96fa(%rip), %rbx      # 0x410881
               	movq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	-0x50(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movq	-0x38(%rbp), %r15
               	movq	(%r15), %r14
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
               	jmp	0x40716a <.text+0x6d0a>
               	leaq	0x96ae(%rip), %rbx      # 0x410896
               	movq	-0x58(%rbp), %r15
               	movq	-0x50(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40738d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movabsq	$-0x1, %r12
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
               	addb	%al, (%rax)
