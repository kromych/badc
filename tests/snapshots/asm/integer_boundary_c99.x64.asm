
integer_boundary_c99.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400450 <.text+0x150>
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
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40038b <.text+0x8b>
               	leaq	0xfdaa(%rip), %rdi      # 0x410108
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
               	leaq	0xfd87(%rip), %rdi      # 0x410120
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd75(%rip), %rsi      # 0x410126
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd64(%rip), %r9       # 0x41012d
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
               	callq	0x4026d7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40041c <.text+0x11c>
               	leaq	0xfd04(%rip), %r14      # 0x410108
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40041c <.text+0x11c>
               	leaq	0xfce5(%rip), %r12      # 0x410108
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
               	subq	$0x240, %rsp            # imm = 0x240
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	jmp	0x400473 <.text+0x173>
               	movl	$0x1, %r11d
               	cmpq	$0x0, %r11
               	jne	0x4004eb <.text+0x1eb>
               	jmp	0x4004a0 <.text+0x1a0>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400473 <.text+0x173>
               	jmp	0x4004f0 <.text+0x1f0>
               	leaq	0xfcb1(%rip), %r11      # 0x410158
               	movl	$0x64, %ebx
               	movl	%ebx, (%r11)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfc99(%rip), %r15      # 0x410160
               	movl	$0x36, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4004eb <.text+0x1eb>
               	jmp	0x40048b <.text+0x18b>
               	movl	$0x1, %esi
               	cmpq	$0x0, %rsi
               	jne	0x400566 <.text+0x266>
               	jmp	0x40051c <.text+0x21c>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4004f0 <.text+0x1f0>
               	jmp	0x40056b <.text+0x26b>
               	leaq	0xfc35(%rip), %rsi      # 0x410158
               	movl	$0x65, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfc39(%rip), %r14      # 0x41017b
               	movl	$0x37, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400566 <.text+0x266>
               	jmp	0x400507 <.text+0x207>
               	movl	$0x1, %esi
               	cmpq	$0x0, %rsi
               	jne	0x4005e1 <.text+0x2e1>
               	jmp	0x400597 <.text+0x297>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40056b <.text+0x26b>
               	jmp	0x4005e6 <.text+0x2e6>
               	leaq	0xfbba(%rip), %rsi      # 0x410158
               	movl	$0x66, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfbd9(%rip), %r15      # 0x410196
               	movl	$0x38, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4005e1 <.text+0x2e1>
               	jmp	0x400582 <.text+0x282>
               	movl	$0x1, %esi
               	cmpq	$0x0, %rsi
               	jne	0x40065c <.text+0x35c>
               	jmp	0x400612 <.text+0x312>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4005e6 <.text+0x2e6>
               	jmp	0x400661 <.text+0x361>
               	leaq	0xfb3f(%rip), %rsi      # 0x410158
               	movl	$0x67, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfb79(%rip), %r14      # 0x4101b1
               	movl	$0x39, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x40065c <.text+0x35c>
               	jmp	0x4005fd <.text+0x2fd>
               	movl	$0x1, %esi
               	cmpq	$0x0, %rsi
               	jne	0x4006d7 <.text+0x3d7>
               	jmp	0x40068d <.text+0x38d>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400661 <.text+0x361>
               	jmp	0x4006dc <.text+0x3dc>
               	leaq	0xfac4(%rip), %rsi      # 0x410158
               	movl	$0x68, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfb19(%rip), %r15      # 0x4101cc
               	movl	$0x3a, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4006d7 <.text+0x3d7>
               	jmp	0x400678 <.text+0x378>
               	movl	$0x1, %esi
               	cmpq	$0x0, %rsi
               	jne	0x400752 <.text+0x452>
               	jmp	0x400708 <.text+0x408>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4006dc <.text+0x3dc>
               	jmp	0x400757 <.text+0x457>
               	leaq	0xfa49(%rip), %rsi      # 0x410158
               	movl	$0x69, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfab9(%rip), %r14      # 0x4101e7
               	movl	$0x3b, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400752 <.text+0x452>
               	jmp	0x4006f3 <.text+0x3f3>
               	movl	$0x1, %esi
               	cmpq	$0x0, %rsi
               	jne	0x4007cd <.text+0x4cd>
               	jmp	0x400783 <.text+0x483>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400757 <.text+0x457>
               	jmp	0x4007d2 <.text+0x4d2>
               	leaq	0xf9ce(%rip), %rsi      # 0x410158
               	movl	$0x6a, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfa59(%rip), %r15      # 0x410202
               	movl	$0x3c, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4007cd <.text+0x4cd>
               	jmp	0x40076e <.text+0x46e>
               	movl	$0x1, %esi
               	cmpq	$0x0, %rsi
               	jne	0x400851 <.text+0x551>
               	jmp	0x400807 <.text+0x507>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4007d2 <.text+0x4d2>
               	movl	$0xff, %esi
               	movb	%sil, -0x8(%rbp)
               	jmp	0x400856 <.text+0x556>
               	leaq	0xf94a(%rip), %rsi      # 0x410158
               	movl	$0x6b, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf9f0(%rip), %r14      # 0x41021d
               	movl	$0x3d, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400851 <.text+0x551>
               	jmp	0x4007e9 <.text+0x4e9>
               	movzbq	-0x8(%rbp), %rsi
               	movq	%rsi, %r12
               	xorq	$0xff, %r12
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%r12, %rsi
               	cmpq	$0x0, %rsi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400904 <.text+0x604>
               	jmp	0x4008b8 <.text+0x5b8>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400856 <.text+0x556>
               	leaq	-0x8(%rbp), %rsi
               	movzbq	(%rsi), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movb	%r12b, (%rsi)
               	jmp	0x400909 <.text+0x609>
               	leaq	0xf899(%rip), %r12      # 0x410158
               	movl	$0x6e, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf958(%rip), %r12      # 0x410238
               	movl	$0x42, %r15d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400904 <.text+0x604>
               	jmp	0x40088e <.text+0x58e>
               	movzbq	-0x8(%rbp), %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4009ae <.text+0x6ae>
               	jmp	0x400962 <.text+0x662>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400909 <.text+0x609>
               	leaq	-0x8(%rbp), %rsi
               	movzbq	(%rsi), %r15
               	movq	%r15, %r12
               	addq	$-0x1, %r12
               	movb	%r12b, (%rsi)
               	jmp	0x4009b3 <.text+0x6b3>
               	leaq	0xf7ef(%rip), %r12      # 0x410158
               	movl	$0x6f, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf8c9(%rip), %r12      # 0x410253
               	movl	$0x44, %r15d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4009ae <.text+0x6ae>
               	jmp	0x400938 <.text+0x638>
               	movzbq	-0x8(%rbp), %r12
               	movq	%r12, %r15
               	xorq	$0xff, %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400a5a <.text+0x75a>
               	jmp	0x400a0f <.text+0x70f>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4009b3 <.text+0x6b3>
               	movl	$0x7f, %r10d
               	movq	%r10, 0xf8(%rsp)
               	jmp	0x400a5f <.text+0x75f>
               	leaq	0xf742(%rip), %r15      # 0x410158
               	movl	$0x70, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf838(%rip), %r15      # 0x41026e
               	movl	$0x46, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400a5a <.text+0x75a>
               	jmp	0x4009ec <.text+0x6ec>
               	movq	0xf8(%rsp), %r12
               	movsbq	%r12b, %r12
               	cmpq	$0x7f, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400afa <.text+0x7fa>
               	jmp	0x400aaf <.text+0x7af>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400a5f <.text+0x75f>
               	movabsq	$-0x80, %rsi
               	movb	%sil, -0x18(%rbp)
               	jmp	0x400aff <.text+0x7ff>
               	leaq	0xf6a2(%rip), %r15      # 0x410158
               	movl	$0x71, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf7b2(%rip), %r15      # 0x410289
               	movl	$0x49, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400afa <.text+0x7fa>
               	jmp	0x400a8c <.text+0x78c>
               	movsbq	-0x18(%rbp), %rsi
               	cmpq	$-0x80, %rsi
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400b9b <.text+0x89b>
               	jmp	0x400b4f <.text+0x84f>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400aff <.text+0x7ff>
               	leaq	-0x18(%rbp), %rsi
               	movsbq	(%rsi), %r12
               	movq	%r12, %rbx
               	addq	$-0x1, %rbx
               	movb	%bl, (%rsi)
               	jmp	0x400ba0 <.text+0x8a0>
               	leaq	0xf602(%rip), %rbx      # 0x410158
               	movl	$0x72, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf72d(%rip), %rbx      # 0x4102a4
               	movl	$0x4b, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400b9b <.text+0x89b>
               	jmp	0x400b25 <.text+0x825>
               	movsbq	-0x18(%rbp), %rbx
               	movq	%rbx, %r12
               	andq	$0xff, %r12
               	movq	%r12, %rbx
               	xorq	$0x7f, %rbx
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	$0x0, %r12
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400c4d <.text+0x94d>
               	jmp	0x400c01 <.text+0x901>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400ba0 <.text+0x8a0>
               	movl	$0xffff, %esi           # imm = 0xFFFF
               	movw	%si, -0x20(%rbp)
               	jmp	0x400c52 <.text+0x952>
               	leaq	0xf550(%rip), %rbx      # 0x410158
               	movl	$0x73, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf696(%rip), %rbx      # 0x4102bf
               	movl	$0x4d, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400c4d <.text+0x94d>
               	jmp	0x400be3 <.text+0x8e3>
               	movzwq	-0x20(%rbp), %rsi
               	movq	%rsi, %r12
               	xorq	$0xffff, %r12           # imm = 0xFFFF
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%r12, %rsi
               	cmpq	$0x0, %rsi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400d02 <.text+0xa02>
               	jmp	0x400cb5 <.text+0x9b5>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400c52 <.text+0x952>
               	leaq	-0x20(%rbp), %rsi
               	movzwq	(%rsi), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movw	%r12w, (%rsi)
               	jmp	0x400d07 <.text+0xa07>
               	leaq	0xf49c(%rip), %r12      # 0x410158
               	movl	$0x78, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf5fc(%rip), %r12      # 0x4102da
               	movl	$0x53, %r15d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400d02 <.text+0xa02>
               	jmp	0x400c8a <.text+0x98a>
               	movzwq	-0x20(%rbp), %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400db5 <.text+0xab5>
               	jmp	0x400d68 <.text+0xa68>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400d07 <.text+0xa07>
               	xorq	%rsi, %rsi
               	movw	%si, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r15
               	movzwq	(%r15), %rsi
               	movq	%rsi, %r12
               	addq	$-0x1, %r12
               	movw	%r12w, (%r15)
               	jmp	0x400dba <.text+0xaba>
               	leaq	0xf3e9(%rip), %r12      # 0x410158
               	movl	$0x79, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf564(%rip), %r12      # 0x4102f5
               	movl	$0x55, %r15d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400db5 <.text+0xab5>
               	jmp	0x400d36 <.text+0xa36>
               	movzwq	-0x20(%rbp), %r12
               	movq	%r12, %rsi
               	xorq	$0xffff, %rsi           # imm = 0xFFFF
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rsi, %r12
               	cmpq	$0x0, %r12
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x400e62 <.text+0xb62>
               	jmp	0x400e16 <.text+0xb16>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400dba <.text+0xaba>
               	movl	$0x7fff, %r10d          # imm = 0x7FFF
               	movq	%r10, 0xf0(%rsp)
               	jmp	0x400e67 <.text+0xb67>
               	leaq	0xf33b(%rip), %rsi      # 0x410158
               	movl	$0x7a, %r14d
               	movl	%r14d, (%rsi)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf4d2(%rip), %rbx      # 0x410310
               	movl	$0x58, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400e62 <.text+0xb62>
               	jmp	0x400df3 <.text+0xaf3>
               	movq	0xf0(%rsp), %r12
               	movswq	%r12w, %r12
               	cmpq	$0x7fff, %r12           # imm = 0x7FFF
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400f06 <.text+0xc06>
               	jmp	0x400ebb <.text+0xbbb>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400e67 <.text+0xb67>
               	movabsq	$-0x8000, %r10          # imm = 0x8000
               	movq	%r10, 0xe8(%rsp)
               	jmp	0x400f0b <.text+0xc0b>
               	leaq	0xf296(%rip), %rbx      # 0x410158
               	movl	$0x7b, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf449(%rip), %rbx      # 0x41032b
               	movl	$0x5b, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400f06 <.text+0xc06>
               	jmp	0x400e94 <.text+0xb94>
               	movq	0xe8(%rsp), %r14
               	movswq	%r14w, %r14
               	cmpq	$-0x8000, %r14          # imm = 0x8000
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400fb6 <.text+0xcb6>
               	jmp	0x400f6b <.text+0xc6b>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400f0b <.text+0xc0b>
               	movq	0xe8(%rsp), %rsi
               	movswq	%si, %rsi
               	movq	%rsi, %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, 0xe0(%rsp)
               	jmp	0x400fbb <.text+0xcbb>
               	leaq	0xf1e6(%rip), %rbx      # 0x410158
               	movl	$0x7c, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf3b4(%rip), %rbx      # 0x410346
               	movl	$0x5d, %r15d
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400fb6 <.text+0xcb6>
               	jmp	0x400f38 <.text+0xc38>
               	movq	0xe0(%rsp), %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movq	%rsi, %rbx
               	xorq	$0x8000, %rbx           # imm = 0x8000
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rsi
               	cmpq	$0x0, %rsi
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401071 <.text+0xd71>
               	jmp	0x401026 <.text+0xd26>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400fbb <.text+0xcbb>
               	movl	$0x12345, %esi          # imm = 0x12345
               	movslq	%esi, %r12
               	movswq	%r12w, %r10
               	movq	%r10, 0xd8(%rsp)
               	jmp	0x401076 <.text+0xd76>
               	leaq	0xf12b(%rip), %rbx      # 0x410158
               	movl	$0x7d, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf314(%rip), %rbx      # 0x410361
               	movl	$0x5f, %r12d
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401071 <.text+0xd71>
               	jmp	0x400ffd <.text+0xcfd>
               	movq	0xd8(%rsp), %rsi
               	movswq	%si, %rsi
               	cmpq	$0x2345, %rsi           # imm = 0x2345
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401119 <.text+0xe19>
               	jmp	0x4010ce <.text+0xdce>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401076 <.text+0xd76>
               	movabsq	$-0x2a, %rsi
               	movswq	%si, %r10
               	movq	%r10, 0xd0(%rsp)
               	jmp	0x40111e <.text+0xe1e>
               	leaq	0xf083(%rip), %rbx      # 0x410158
               	movl	$0x7e, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf287(%rip), %rbx      # 0x41037c
               	movl	$0x64, %r15d
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401119 <.text+0xe19>
               	jmp	0x4010a3 <.text+0xda3>
               	movq	0xd0(%rsp), %rsi
               	movslq	%esi, %rsi
               	cmpq	$-0x2a, %rsi
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4011cf <.text+0xecf>
               	jmp	0x401184 <.text+0xe84>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40111e <.text+0xe1e>
               	movl	$0xffff, %r10d          # imm = 0xFFFF
               	movq	%r10, 0xc8(%rsp)
               	movq	0xc8(%rsp), %r10
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movq	%r10, 0xc0(%rsp)
               	jmp	0x4011d4 <.text+0xed4>
               	leaq	0xefcd(%rip), %rbx      # 0x410158
               	movl	$0x7f, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf1ec(%rip), %rbx      # 0x410397
               	movl	$0x69, %r12d
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4011cf <.text+0xecf>
               	jmp	0x40114a <.text+0xe4a>
               	movq	0xc0(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movq	%rbx, %r12
               	xorq	$0xffff, %r12           # imm = 0xFFFF
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	$0x0, %rbx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401279 <.text+0xf79>
               	jmp	0x40122d <.text+0xf2d>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4011d4 <.text+0xed4>
               	jmp	0x40127e <.text+0xf7e>
               	leaq	0xef24(%rip), %r12      # 0x410158
               	movl	$0x80, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf15d(%rip), %r12      # 0x4103b2
               	movl	$0x6e, %r14d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401279 <.text+0xf79>
               	jmp	0x401218 <.text+0xf18>
               	movq	0xc8(%rsp), %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	cmpq	$0xffff, %rsi           # imm = 0xFFFF
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401316 <.text+0x1016>
               	jmp	0x4012cb <.text+0xfcb>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40127e <.text+0xf7e>
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	movl	%esi, -0x70(%rbp)
               	jmp	0x40131b <.text+0x101b>
               	leaq	0xee86(%rip), %r14      # 0x410158
               	movl	$0x81, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf0db(%rip), %r14      # 0x4103cd
               	movl	$0x70, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401316 <.text+0x1016>
               	jmp	0x4012ae <.text+0xfae>
               	movl	-0x70(%rbp), %esi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rsi, %r15
               	cmpq	%r11, %rsi
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4013b8 <.text+0x10b8>
               	jmp	0x40136d <.text+0x106d>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40131b <.text+0x101b>
               	leaq	-0x70(%rbp), %rsi
               	movl	(%rsi), %r12d
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movl	%r15d, (%rsi)
               	jmp	0x4013bd <.text+0x10bd>
               	leaq	0xede4(%rip), %r15      # 0x410158
               	movl	$0x82, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf054(%rip), %r15      # 0x4103e8
               	movl	$0x76, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4013b8 <.text+0x10b8>
               	jmp	0x401344 <.text+0x1044>
               	movl	-0x70(%rbp), %r15d
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x401467 <.text+0x1167>
               	jmp	0x40141c <.text+0x111c>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4013bd <.text+0x10bd>
               	xorq	%rsi, %rsi
               	movl	%esi, -0x70(%rbp)
               	leaq	-0x70(%rbp), %r12
               	movl	(%r12), %esi
               	movq	%rsi, %r15
               	addq	$-0x1, %r15
               	movl	%r15d, (%r12)
               	jmp	0x40146c <.text+0x116c>
               	leaq	0xed35(%rip), %r15      # 0x410158
               	movl	$0x83, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xefc0(%rip), %r15      # 0x410403
               	movl	$0x78, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401467 <.text+0x1167>
               	jmp	0x4013eb <.text+0x10eb>
               	movl	-0x70(%rbp), %r15d
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%r15, %rsi
               	cmpq	%r11, %r15
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x401503 <.text+0x1203>
               	jmp	0x4014b9 <.text+0x11b9>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40146c <.text+0x116c>
               	movl	$0x7fffffff, %r10d      # imm = 0x7FFFFFFF
               	movq	%r10, 0xb8(%rsp)
               	jmp	0x401508 <.text+0x1208>
               	leaq	0xec98(%rip), %rsi      # 0x410158
               	movl	$0x84, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xef3f(%rip), %r14      # 0x41041e
               	movl	$0x7b, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401503 <.text+0x1203>
               	jmp	0x401496 <.text+0x1196>
               	movq	0xb8(%rsp), %r15
               	movslq	%r15d, %r15
               	cmpq	$0x7fffffff, %r15       # imm = 0x7FFFFFFF
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4015a9 <.text+0x12a9>
               	jmp	0x40155e <.text+0x125e>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401508 <.text+0x1208>
               	movabsq	$-0x80000000, %rsi      # imm = 0x80000000
               	movslq	%esi, %r10
               	movq	%r10, 0xb0(%rsp)
               	jmp	0x4015ae <.text+0x12ae>
               	leaq	0xebf3(%rip), %r14      # 0x410158
               	movl	$0x85, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xeeb3(%rip), %r14      # 0x410439
               	movl	$0x7e, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4015a9 <.text+0x12a9>
               	jmp	0x401534 <.text+0x1234>
               	movq	0xb0(%rsp), %rbx
               	movslq	%ebx, %rbx
               	cmpq	$-0x80000000, %rbx      # imm = 0x80000000
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x40164e <.text+0x134e>
               	jmp	0x401602 <.text+0x1302>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4015ae <.text+0x12ae>
               	movq	0xb0(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0xa8(%rsp)
               	jmp	0x401653 <.text+0x1353>
               	leaq	0xeb4f(%rip), %r14      # 0x410158
               	movl	$0x86, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xee2a(%rip), %r14      # 0x410454
               	movl	$0x80, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x40164e <.text+0x134e>
               	jmp	0x4015da <.text+0x12da>
               	movq	0xa8(%rsp), %r12
               	cmpq	$-0x80000000, %r12      # imm = 0x80000000
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4016f0 <.text+0x13f0>
               	jmp	0x4016a4 <.text+0x13a4>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401653 <.text+0x1353>
               	movq	0xb0(%rsp), %rsi
               	movslq	%esi, %rsi
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rsi, %rbx
               	jmp	0x4016f5 <.text+0x13f5>
               	leaq	0xeaad(%rip), %r12      # 0x410158
               	movl	$0x87, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xeda3(%rip), %r12      # 0x41046f
               	movl	$0x86, %r15d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4016f0 <.text+0x13f0>
               	jmp	0x40167c <.text+0x137c>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%rbx, %rsi
               	cmpq	%r11, %rbx
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x401787 <.text+0x1487>
               	jmp	0x401741 <.text+0x1441>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4016f5 <.text+0x13f5>
               	movabsq	$-0x1, %rsi
               	movq	%rsi, -0x98(%rbp)
               	jmp	0x40178c <.text+0x148c>
               	leaq	0xea10(%rip), %rsi      # 0x410158
               	movl	$0x88, %r15d
               	movl	%r15d, (%rsi)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xed21(%rip), %r12      # 0x41048a
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401787 <.text+0x1487>
               	jmp	0x40171b <.text+0x141b>
               	movq	-0x98(%rbp), %rsi
               	cmpq	$-0x1, %rsi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x40182d <.text+0x152d>
               	jmp	0x4017e0 <.text+0x14e0>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40178c <.text+0x148c>
               	leaq	-0x98(%rbp), %rsi
               	movq	(%rsi), %r14
               	movq	%r14, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rsi)
               	jmp	0x401832 <.text+0x1532>
               	leaq	0xe971(%rip), %r12      # 0x410158
               	movl	$0x8c, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xec9c(%rip), %r12      # 0x4104a5
               	movl	$0x8e, %r14d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x40182d <.text+0x152d>
               	jmp	0x4017b4 <.text+0x14b4>
               	movq	-0x98(%rbp), %r12
               	cmpq	$0x0, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4018d2 <.text+0x15d2>
               	jmp	0x401886 <.text+0x1586>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401832 <.text+0x1532>
               	leaq	-0x98(%rbp), %rsi
               	movq	(%rsi), %r12
               	movq	%r12, %r14
               	addq	$-0x1, %r14
               	movq	%r14, (%rsi)
               	jmp	0x4018d7 <.text+0x15d7>
               	leaq	0xe8cb(%rip), %r14      # 0x410158
               	movl	$0x8d, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xec12(%rip), %r14      # 0x4104c0
               	movl	$0x90, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4018d2 <.text+0x15d2>
               	jmp	0x40185a <.text+0x155a>
               	movq	-0x98(%rbp), %r14
               	cmpq	$-0x1, %r14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401973 <.text+0x1673>
               	jmp	0x401926 <.text+0x1626>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4018d7 <.text+0x15d7>
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r10, 0xa0(%rsp)
               	jmp	0x401978 <.text+0x1678>
               	leaq	0xe82b(%rip), %r12      # 0x410158
               	movl	$0x8e, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xeb8c(%rip), %r12      # 0x4104db
               	movl	$0x92, %r14d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401973 <.text+0x1673>
               	jmp	0x4018ff <.text+0x15ff>
               	movq	0xa0(%rsp), %r14
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401a19 <.text+0x1719>
               	jmp	0x4019ce <.text+0x16ce>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401978 <.text+0x1678>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x98(%rsp)
               	jmp	0x401a1e <.text+0x171e>
               	leaq	0xe783(%rip), %r14      # 0x410158
               	movl	$0x8f, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xeb01(%rip), %r14      # 0x4104f6
               	movl	$0x95, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401a19 <.text+0x1719>
               	jmp	0x4019a7 <.text+0x16a7>
               	movq	0x98(%rsp), %r15
               	sarq	$0x1, %r15
               	cmpq	$-0x1, %r15
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401abd <.text+0x17bd>
               	jmp	0x401a72 <.text+0x1772>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401a1e <.text+0x171e>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, 0x90(%rsp)
               	jmp	0x401ac2 <.text+0x17c2>
               	leaq	0xe6df(%rip), %r14      # 0x410158
               	movl	$0x90, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xea77(%rip), %r14      # 0x410511
               	movl	$0x9a, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401abd <.text+0x17bd>
               	jmp	0x401a4b <.text+0x174b>
               	movq	0x90(%rsp), %rbx
               	shrq	$0x1, %rbx
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%rbx, %r14
               	cmpq	%r11, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401b6b <.text+0x186b>
               	jmp	0x401b1f <.text+0x181f>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401ac2 <.text+0x17c2>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x88(%rsp)
               	jmp	0x401b70 <.text+0x1870>
               	leaq	0xe632(%rip), %r14      # 0x410158
               	movl	$0x91, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe9e5(%rip), %r14      # 0x41052c
               	movl	$0x9d, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401b6b <.text+0x186b>
               	jmp	0x401af8 <.text+0x17f8>
               	movq	0x88(%rsp), %r12
               	shrq	$0x20, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%r12, %r14
               	cmpq	%r11, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401c25 <.text+0x1925>
               	jmp	0x401bda <.text+0x18da>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401b70 <.text+0x1870>
               	movabsq	$-0x12c, %r10           # imm = 0xFED4
               	movq	%r10, 0x78(%rsp)
               	movq	0x78(%rsp), %r15
               	movslq	%r15d, %r15
               	movsbq	%r15b, %r10
               	movq	%r10, 0x80(%rsp)
               	jmp	0x401c2a <.text+0x192a>
               	leaq	0xe577(%rip), %r14      # 0x410158
               	movl	$0x92, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe946(%rip), %r14      # 0x410547
               	movl	$0xa0, %r15d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401c25 <.text+0x1925>
               	jmp	0x401ba2 <.text+0x18a2>
               	movq	0x80(%rsp), %r14
               	movsbq	%r14b, %r14
               	movl	$0xd4, %r15d
               	movsbq	%r15b, %r15
               	cmpq	%r15, %r14
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x401cbd <.text+0x19bd>
               	jmp	0x401c72 <.text+0x1972>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401c2a <.text+0x192a>
               	jmp	0x401cc2 <.text+0x19c2>
               	leaq	0xe4df(%rip), %rsi      # 0x410158
               	movl	$0x96, %r14d
               	movl	%r14d, (%rsi)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe8c8(%rip), %r15      # 0x410562
               	movl	$0xa9, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401cbd <.text+0x19bd>
               	jmp	0x401c5d <.text+0x195d>
               	movq	0x80(%rsp), %rsi
               	movsbq	%sil, %rsi
               	cmpq	$-0x2c, %rsi
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401d67 <.text+0x1a67>
               	jmp	0x401d1b <.text+0x1a1b>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401cc2 <.text+0x19c2>
               	movq	0x78(%rsp), %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x70(%rsp)
               	jmp	0x401d6c <.text+0x1a6c>
               	leaq	0xe436(%rip), %rbx      # 0x410158
               	movl	$0x97, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xe83a(%rip), %rbx      # 0x41057d
               	movl	$0xaa, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401d67 <.text+0x1a67>
               	jmp	0x401cef <.text+0x19ef>
               	movq	0x70(%rsp), %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %rbx
               	xorq	$0xd4, %rbx
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rsi
               	cmpq	$0x0, %rsi
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401e0b <.text+0x1b0b>
               	jmp	0x401dc0 <.text+0x1ac0>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401d6c <.text+0x1a6c>
               	jmp	0x401e10 <.text+0x1b10>
               	leaq	0xe391(%rip), %rbx      # 0x410158
               	movl	$0x98, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xe7b1(%rip), %rbx      # 0x410598
               	movl	$0xaf, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401e0b <.text+0x1b0b>
               	jmp	0x401dab <.text+0x1aab>
               	movq	0x70(%rsp), %rsi
               	andq	$0xff, %rsi
               	cmpq	$0xd4, %rsi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401eaf <.text+0x1baf>
               	jmp	0x401e63 <.text+0x1b63>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401e10 <.text+0x1b10>
               	movl	$0x12345, %esi          # imm = 0x12345
               	movslq	%esi, %r15
               	movswq	%r15w, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	0x401eb4 <.text+0x1bb4>
               	leaq	0xe2ee(%rip), %r14      # 0x410158
               	movl	$0x99, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe728(%rip), %r14      # 0x4105b3
               	movl	$0xb0, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401eaf <.text+0x1baf>
               	jmp	0x401e3d <.text+0x1b3d>
               	movq	0x68(%rsp), %rsi
               	movswq	%si, %rsi
               	cmpq	$0x2345, %rsi           # imm = 0x2345
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401f3f <.text+0x1c3f>
               	jmp	0x401ef3 <.text+0x1bf3>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401eb4 <.text+0x1bb4>
               	jmp	0x401f44 <.text+0x1c44>
               	leaq	0xe25e(%rip), %r14      # 0x410158
               	movl	$0x9a, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe6b3(%rip), %r14      # 0x4105ce
               	movl	$0xb5, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401f3f <.text+0x1c3f>
               	jmp	0x401ede <.text+0x1bde>
               	movq	0x68(%rsp), %rsi
               	movswq	%si, %rsi
               	cmpq	$0x2345, %rsi           # imm = 0x2345
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401fdf <.text+0x1cdf>
               	jmp	0x401f94 <.text+0x1c94>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401f44 <.text+0x1c44>
               	movl	$0x1ffff, %esi          # imm = 0x1FFFF
               	movslq	%esi, %rbx
               	movswq	%bx, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	0x401fe4 <.text+0x1ce4>
               	leaq	0xe1bd(%rip), %r12      # 0x410158
               	movl	$0x9b, %r15d
               	movl	%r15d, (%r12)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xe62d(%rip), %r12      # 0x4105e9
               	movl	$0xb6, %ebx
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x401fdf <.text+0x1cdf>
               	jmp	0x401f6e <.text+0x1c6e>
               	movq	0x60(%rsp), %rsi
               	movswq	%si, %rsi
               	cmpq	$-0x1, %rsi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x40206f <.text+0x1d6f>
               	jmp	0x402023 <.text+0x1d23>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401fe4 <.text+0x1ce4>
               	jmp	0x402074 <.text+0x1d74>
               	leaq	0xe12e(%rip), %r12      # 0x410158
               	movl	$0x9c, %ebx
               	movl	%ebx, (%r12)
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xe5b9(%rip), %r12      # 0x410604
               	movl	$0xba, %r15d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x40206f <.text+0x1d6f>
               	jmp	0x40200e <.text+0x1d0e>
               	movq	0x60(%rsp), %rsi
               	movswq	%si, %rsi
               	cmpq	$-0x1, %rsi
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x402114 <.text+0x1e14>
               	jmp	0x4020c9 <.text+0x1dc9>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x402074 <.text+0x1d74>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x50(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x58(%rsp)
               	jmp	0x402119 <.text+0x1e19>
               	leaq	0xe088(%rip), %r15      # 0x410158
               	movl	$0x9d, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe52f(%rip), %r15      # 0x41061f
               	movl	$0xbb, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x402114 <.text+0x1e14>
               	jmp	0x40209e <.text+0x1d9e>
               	movq	0x50(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	movq	0x58(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	cmpq	%r14, %r15
               	seta	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x4021de <.text+0x1ede>
               	jmp	0x402193 <.text+0x1e93>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x402119 <.text+0x1e19>
               	movq	0x50(%rsp), %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	movslq	%esi, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movslq	%ebx, %r10
               	movq	%r10, 0x48(%rsp)
               	jmp	0x4021e3 <.text+0x1ee3>
               	leaq	0xdfbe(%rip), %rsi      # 0x410158
               	movl	$0xa0, %r15d
               	movl	%r15d, (%rsi)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe47f(%rip), %r14      # 0x41063a
               	movl	$0xc2, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4021de <.text+0x1ede>
               	jmp	0x402152 <.text+0x1e52>
               	movq	0x40(%rsp), %r14
               	movslq	%r14d, %r14
               	movq	0x48(%rsp), %rbx
               	movslq	%ebx, %rbx
               	cmpq	%rbx, %r14
               	setl	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x40227b <.text+0x1f7b>
               	jmp	0x402230 <.text+0x1f30>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4021e3 <.text+0x1ee3>
               	movl	$0x1, %r10d
               	movq	%r10, 0x38(%rsp)
               	jmp	0x402280 <.text+0x1f80>
               	leaq	0xdf21(%rip), %rsi      # 0x410158
               	movl	$0xa1, %r14d
               	movl	%r14d, (%rsi)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe3fe(%rip), %rbx      # 0x410655
               	movl	$0xc5, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x40227b <.text+0x1f7b>
               	jmp	0x402210 <.text+0x1f10>
               	movq	0x38(%rsp), %r15
               	movslq	%r15d, %r15
               	movq	%r15, %rbx
               	shlq	$0x1e, %rbx
               	cmpq	$0x40000000, %rbx       # imm = 0x40000000
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40231c <.text+0x201c>
               	jmp	0x4022d0 <.text+0x1fd0>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x402280 <.text+0x1f80>
               	movl	$0x1, %r10d
               	movq	%r10, 0x30(%rsp)
               	jmp	0x402321 <.text+0x2021>
               	leaq	0xde81(%rip), %r15      # 0x410158
               	movl	$0xaa, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe378(%rip), %r15      # 0x410670
               	movl	$0xcd, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x40231c <.text+0x201c>
               	jmp	0x4022b0 <.text+0x1fb0>
               	movq	0x30(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movq	%r14, %r15
               	shlq	$0x1f, %r15
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r15, %r14
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%r14, %r15
               	cmpq	%r11, %r14
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4023d4 <.text+0x20d4>
               	jmp	0x402389 <.text+0x2089>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x402321 <.text+0x2021>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x28(%rsp)
               	jmp	0x4023d9 <.text+0x20d9>
               	leaq	0xddc8(%rip), %r15      # 0x410158
               	movl	$0xab, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xe2db(%rip), %r15      # 0x41068b
               	movl	$0xcf, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4023d4 <.text+0x20d4>
               	jmp	0x402365 <.text+0x2065>
               	movq	0x28(%rsp), %r12
               	movslq	%r12d, %r12
               	cmpq	$-0x1, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40246d <.text+0x216d>
               	jmp	0x402422 <.text+0x2122>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4023d9 <.text+0x20d9>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x20(%rsp)
               	jmp	0x402472 <.text+0x2172>
               	leaq	0xdd2f(%rip), %r15      # 0x410158
               	movl	$0xac, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xe25c(%rip), %r15      # 0x4106a6
               	movl	$0xd3, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x40246d <.text+0x216d>
               	jmp	0x402402 <.text+0x2102>
               	movq	0x20(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rbx, %r15
               	cmpq	%r11, %rbx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40251e <.text+0x221e>
               	jmp	0x4024d2 <.text+0x21d2>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x402472 <.text+0x2172>
               	leaq	0xdc9b(%rip), %rsi      # 0x410158
               	movslq	(%rsi), %r14
               	cmpq	$0x0, %r14
               	jne	0x40255f <.text+0x225f>
               	jmp	0x402523 <.text+0x2223>
               	leaq	0xdc7f(%rip), %r15      # 0x410158
               	movl	$0xad, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xe1c7(%rip), %r15      # 0x4106c1
               	movl	$0xd5, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x4026dd <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x40251e <.text+0x221e>
               	jmp	0x4024a6 <.text+0x21a6>
               	leaq	0xe1b2(%rip), %r12      # 0x4106dc
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x4026e3 <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	leaq	0xdbf2(%rip), %r12      # 0x410158
               	movslq	(%r12), %rsi
               	movq	%rsi, %rcx
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
