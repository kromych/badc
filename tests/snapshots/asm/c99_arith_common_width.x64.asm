
c99_arith_common_width.x64:	file format elf64-x86-64

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
               	callq	0x400bc7 <dlsym>
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
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	addq	$0x1, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r11, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	0x40047d <.text+0x17d>
               	movq	0x68(%rsp), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	jne	0x40052a <.text+0x22a>
               	jmp	0x4004e2 <.text+0x1e2>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40047d <.text+0x17d>
               	xorq	%rax, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	subq	$0x1, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	0x40052f <.text+0x22f>
               	leaq	0xfc6f(%rip), %r8       # 0x410158
               	movl	$0x1, %r12d
               	movl	%r12d, (%r8)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfc56(%rip), %r14      # 0x410160
               	movl	$0x1a, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400bcd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40052a <.text+0x22a>
               	jmp	0x4004ac <.text+0x1ac>
               	movq	0x60(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4005e4 <.text+0x2e4>
               	jmp	0x4005a2 <.text+0x2a2>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40052f <.text+0x22f>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %r12d
               	movslq	%eax, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	subq	%r12, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	jmp	0x4005e9 <.text+0x2e9>
               	leaq	0xfbaf(%rip), %r14      # 0x410158
               	movl	$0x2, %ebx
               	movl	%ebx, (%r14)
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfbb3(%rip), %r15      # 0x410176
               	movl	$0x21, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400bcd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4005e4 <.text+0x2e4>
               	jmp	0x400560 <.text+0x260>
               	movq	0x58(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4006a4 <.text+0x3a4>
               	jmp	0x40065c <.text+0x35c>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4005e9 <.text+0x2e9>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ebx
               	movslq	%eax, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	imulq	%rbx, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	0x4006a9 <.text+0x3a9>
               	leaq	0xfaf5(%rip), %r15      # 0x410158
               	movl	$0x3, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfb08(%rip), %r15      # 0x41018c
               	movl	$0x29, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400bcd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4006a4 <.text+0x3a4>
               	jmp	0x40061a <.text+0x31a>
               	movq	0x50(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x40074f <.text+0x44f>
               	jmp	0x400707 <.text+0x407>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4006a9 <.text+0x3a9>
               	movl	$0xc350, %eax           # imm = 0xC350
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	imulq	%rax, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x48(%rsp)
               	jmp	0x400754 <.text+0x454>
               	leaq	0xfa4a(%rip), %r15      # 0x410158
               	movl	$0x4, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfa74(%rip), %r15      # 0x4101a2
               	movl	$0x31, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400bcd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40074f <.text+0x44f>
               	jmp	0x4006da <.text+0x3da>
               	movq	0x48(%rsp), %rax
               	cmpq	$-0x6afd0700, %rax      # imm = 0x9502F900
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400803 <.text+0x503>
               	jmp	0x4007bb <.text+0x4bb>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400754 <.text+0x454>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ebx
               	movslq	%eax, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	addq	%rbx, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	0x400808 <.text+0x508>
               	leaq	0xf996(%rip), %r15      # 0x410158
               	movl	$0x5, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf9d5(%rip), %r15      # 0x4101b8
               	movl	$0x3e, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400bcd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400803 <.text+0x503>
               	jmp	0x40077a <.text+0x47a>
               	movq	0x40(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4008ae <.text+0x5ae>
               	jmp	0x400866 <.text+0x566>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400808 <.text+0x508>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x30(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x38(%rsp)
               	jmp	0x4008b3 <.text+0x5b3>
               	leaq	0xf8eb(%rip), %r15      # 0x410158
               	movl	$0x64, %ebx
               	movl	%ebx, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf941(%rip), %r15      # 0x4101ce
               	movl	$0x4b, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400bcd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4008ae <.text+0x5ae>
               	jmp	0x400837 <.text+0x537>
               	movq	0x38(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	movq	0x30(%rsp), %r12
               	cmpq	%r15, %r12
               	setl	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x40095a <.text+0x65a>
               	jmp	0x400912 <.text+0x612>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4008b3 <.text+0x5b3>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x20(%rsp)
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x28(%rsp)
               	jmp	0x40095f <.text+0x65f>
               	leaq	0xf83f(%rip), %r15      # 0x410158
               	movl	$0x65, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf8aa(%rip), %r15      # 0x4101e4
               	movl	$0x54, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400bcd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40095a <.text+0x65a>
               	jmp	0x4008e3 <.text+0x5e3>
               	movq	0x20(%rsp), %r15
               	movslq	%r15d, %r15
               	movq	0x28(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	xorq	%rbx, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400a16 <.text+0x716>
               	jmp	0x4009ce <.text+0x6ce>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40095f <.text+0x65f>
               	leaq	0xf79f(%rip), %rax      # 0x410158
               	movslq	(%rax), %r12
               	cmpq	$0x0, %r12
               	jne	0x400a54 <.text+0x754>
               	jmp	0x400a1b <.text+0x71b>
               	leaq	0xf783(%rip), %rbx      # 0x410158
               	movl	$0x66, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf805(%rip), %rbx      # 0x4101fa
               	movl	$0x5d, %r12d
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x400bcd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400a16 <.text+0x716>
               	jmp	0x4009a2 <.text+0x6a2>
               	leaq	0xf7ee(%rip), %r15      # 0x410210
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x400bd3 <printf>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	0xf6fd(%rip), %r15      # 0x410158
               	movslq	(%r15), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
