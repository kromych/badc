
c99_arith_common_width.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40044d <.text+0x14d>
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
               	callq	0x400bf7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400419 <.text+0x119>
               	leaq	0xfd07(%rip), %r14      # 0x410108
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400419 <.text+0x119>
               	leaq	0xfce8(%rip), %r12      # 0x410108
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
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
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r11, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	0x400497 <.text+0x197>
               	movq	0x68(%rsp), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400546 <.text+0x246>
               	jmp	0x4004fe <.text+0x1fe>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400497 <.text+0x197>
               	xorq	%rax, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	movq	%rbx, %rax
               	subq	$0x1, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	0x40054b <.text+0x24b>
               	leaq	0xfc53(%rip), %r8       # 0x410158
               	movl	$0x1, %r12d
               	movl	%r12d, (%r8)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfc3a(%rip), %r14      # 0x410160
               	movl	$0x1a, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400bfd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400546 <.text+0x246>
               	jmp	0x4004c6 <.text+0x1c6>
               	movq	0x60(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %r14
               	cmpq	%r11, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x400605 <.text+0x305>
               	jmp	0x4005c3 <.text+0x2c3>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40054b <.text+0x24b>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %r12d
               	movslq	%eax, %r15
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movq	%r15, %r12
               	subq	%rax, %r12
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r12, %r10
               	movq	%r10, 0x58(%rsp)
               	jmp	0x40060a <.text+0x30a>
               	leaq	0xfb8e(%rip), %r14      # 0x410158
               	movl	$0x2, %ebx
               	movl	%ebx, (%r14)
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfb92(%rip), %r15      # 0x410176
               	movl	$0x21, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400bfd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400605 <.text+0x305>
               	jmp	0x40057f <.text+0x27f>
               	movq	0x58(%rsp), %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%r12, %r15
               	cmpq	%r11, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4006ca <.text+0x3ca>
               	jmp	0x400682 <.text+0x382>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40060a <.text+0x30a>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %ebx
               	movslq	%eax, %r15
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movq	%r15, %rbx
               	imulq	%rax, %rbx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	0x4006cf <.text+0x3cf>
               	leaq	0xfacf(%rip), %r15      # 0x410158
               	movl	$0x3, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xfae2(%rip), %r15      # 0x41018c
               	movl	$0x29, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400bfd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4006ca <.text+0x3ca>
               	jmp	0x40063e <.text+0x33e>
               	movq	0x50(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rbx, %r15
               	cmpq	%r11, %rbx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40077f <.text+0x47f>
               	jmp	0x400736 <.text+0x436>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4006cf <.text+0x3cf>
               	movl	$0xc350, %eax           # imm = 0xC350
               	movq	%rax, %r14
               	andq	$0xffff, %r14           # imm = 0xFFFF
               	movq	%r14, %rax
               	imulq	%r14, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x48(%rsp)
               	jmp	0x400784 <.text+0x484>
               	leaq	0xfa1b(%rip), %r15      # 0x410158
               	movl	$0x4, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xfa44(%rip), %r15      # 0x4101a2
               	movl	$0x31, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400bfd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40077f <.text+0x47f>
               	jmp	0x400703 <.text+0x403>
               	movq	0x48(%rsp), %r14
               	cmpq	$-0x6afd0700, %r14      # imm = 0x9502F900
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x400836 <.text+0x536>
               	jmp	0x4007ee <.text+0x4ee>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400784 <.text+0x484>
               	movabsq	$-0x1, %rax
               	movl	$0x1, %r12d
               	movslq	%eax, %r14
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movq	%r14, %r12
               	addq	%rax, %r12
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r12, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	0x40083b <.text+0x53b>
               	leaq	0xf963(%rip), %r14      # 0x410158
               	movl	$0x5, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf9a3(%rip), %r14      # 0x4101b8
               	movl	$0x3e, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400bfd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400836 <.text+0x536>
               	jmp	0x4007aa <.text+0x4aa>
               	movq	0x40(%rsp), %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4008e1 <.text+0x5e1>
               	jmp	0x400899 <.text+0x599>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40083b <.text+0x53b>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x30(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x38(%rsp)
               	jmp	0x4008e6 <.text+0x5e6>
               	leaq	0xf8b8(%rip), %r14      # 0x410158
               	movl	$0x64, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf90d(%rip), %r14      # 0x4101ce
               	movl	$0x4b, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400bfd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x4008e1 <.text+0x5e1>
               	jmp	0x40086a <.text+0x56a>
               	movq	0x38(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movq	0x30(%rsp), %rbx
               	cmpq	%r14, %rbx
               	setl	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40098d <.text+0x68d>
               	jmp	0x400945 <.text+0x645>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4008e6 <.text+0x5e6>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x20(%rsp)
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x28(%rsp)
               	jmp	0x400992 <.text+0x692>
               	leaq	0xf80c(%rip), %rbx      # 0x410158
               	movl	$0x65, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf878(%rip), %rbx      # 0x4101e4
               	movl	$0x54, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x400bfd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x40098d <.text+0x68d>
               	jmp	0x400916 <.text+0x616>
               	movq	0x20(%rsp), %rbx
               	movslq	%ebx, %rbx
               	movq	0x28(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	movq	%rbx, %rax
               	xorq	%r15, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	cmpq	$0x0, %r15
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400a4b <.text+0x74b>
               	jmp	0x400a04 <.text+0x704>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400992 <.text+0x692>
               	leaq	0xf769(%rip), %rax      # 0x410158
               	movslq	(%rax), %r14
               	cmpq	$0x0, %r14
               	jne	0x400a89 <.text+0x789>
               	jmp	0x400a50 <.text+0x750>
               	leaq	0xf74d(%rip), %rax      # 0x410158
               	movl	$0x66, %ebx
               	movl	%ebx, (%rax)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf7d0(%rip), %r15      # 0x4101fa
               	movl	$0x5d, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400bfd <fprintf>
               	movslq	%eax, %rax
               	jmp	0x400a4b <.text+0x74b>
               	jmp	0x4009d8 <.text+0x6d8>
               	leaq	0xf7b9(%rip), %rbx      # 0x410210
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x400c03 <printf>
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
               	leaq	0xf6c8(%rip), %rbx      # 0x410158
               	movslq	(%rbx), %rax
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
