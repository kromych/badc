
c99_arith_common_width.x64:	file format elf64-x86-64

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
               	callq	0x400c17 <dlsym>
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
               	jmp	0x40049a <.text+0x19a>
               	movq	0x68(%rsp), %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x40054c <.text+0x24c>
               	jmp	0x400501 <.text+0x201>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40049a <.text+0x19a>
               	xorq	%rsi, %rsi
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rsi, %rbx
               	movq	%rbx, %rsi
               	subq	$0x1, %rsi
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rsi, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	0x400551 <.text+0x251>
               	leaq	0xfc50(%rip), %r8       # 0x410158
               	movl	$0x1, %r12d
               	movl	%r12d, (%r8)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfc37(%rip), %r14      # 0x410160
               	movl	$0x1a, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400c1d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x40054c <.text+0x24c>
               	jmp	0x4004c9 <.text+0x1c9>
               	movq	0x60(%rsp), %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rsi, %r14
               	cmpq	%r11, %rsi
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x40060e <.text+0x30e>
               	jmp	0x4005c9 <.text+0x2c9>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400551 <.text+0x251>
               	movabsq	$-0x1, %rsi
               	movl	$0x1, %r12d
               	movslq	%esi, %r15
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%r12, %rsi
               	movq	%r15, %r12
               	subq	%rsi, %r12
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r12, %r10
               	movq	%r10, 0x58(%rsp)
               	jmp	0x400613 <.text+0x313>
               	leaq	0xfb88(%rip), %r14      # 0x410158
               	movl	$0x2, %ebx
               	movl	%ebx, (%r14)
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfb8c(%rip), %r15      # 0x410176
               	movl	$0x21, %r12d
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400c1d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x40060e <.text+0x30e>
               	jmp	0x400585 <.text+0x285>
               	movq	0x58(%rsp), %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	movq	%r12, %r15
               	cmpq	%r11, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4006d6 <.text+0x3d6>
               	jmp	0x40068b <.text+0x38b>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400613 <.text+0x313>
               	movabsq	$-0x1, %rsi
               	movl	$0x1, %ebx
               	movslq	%esi, %r15
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rsi
               	movq	%r15, %rbx
               	imulq	%rsi, %rbx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	0x4006db <.text+0x3db>
               	leaq	0xfac6(%rip), %r15      # 0x410158
               	movl	$0x3, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xfad9(%rip), %r15      # 0x41018c
               	movl	$0x29, %ebx
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400c1d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4006d6 <.text+0x3d6>
               	jmp	0x400647 <.text+0x347>
               	movq	0x50(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rbx, %r15
               	cmpq	%r11, %rbx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40078e <.text+0x48e>
               	jmp	0x400742 <.text+0x442>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4006db <.text+0x3db>
               	movl	$0xc350, %esi           # imm = 0xC350
               	movq	%rsi, %r14
               	andq	$0xffff, %r14           # imm = 0xFFFF
               	movq	%r14, %rsi
               	imulq	%r14, %rsi
               	movslq	%esi, %r10
               	movq	%r10, 0x48(%rsp)
               	jmp	0x400793 <.text+0x493>
               	leaq	0xfa0f(%rip), %r15      # 0x410158
               	movl	$0x4, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xfa38(%rip), %r15      # 0x4101a2
               	movl	$0x31, %r14d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400c1d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x40078e <.text+0x48e>
               	jmp	0x40070f <.text+0x40f>
               	movq	0x48(%rsp), %r14
               	cmpq	$-0x6afd0700, %r14      # imm = 0x9502F900
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x400848 <.text+0x548>
               	jmp	0x4007fd <.text+0x4fd>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400793 <.text+0x493>
               	movabsq	$-0x1, %rsi
               	movl	$0x1, %r12d
               	movslq	%esi, %r14
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%r12, %rsi
               	movq	%r14, %r12
               	addq	%rsi, %r12
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r12, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	0x40084d <.text+0x54d>
               	leaq	0xf954(%rip), %r14      # 0x410158
               	movl	$0x5, %ebx
               	movl	%ebx, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf994(%rip), %r14      # 0x4101b8
               	movl	$0x3e, %r12d
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400c1d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400848 <.text+0x548>
               	jmp	0x4007b9 <.text+0x4b9>
               	movq	0x40(%rsp), %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4008f6 <.text+0x5f6>
               	jmp	0x4008ab <.text+0x5ab>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40084d <.text+0x54d>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x30(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x38(%rsp)
               	jmp	0x4008fb <.text+0x5fb>
               	leaq	0xf8a6(%rip), %r14      # 0x410158
               	movl	$0x64, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf8fb(%rip), %r14      # 0x4101ce
               	movl	$0x4b, %ebx
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400c1d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4008f6 <.text+0x5f6>
               	jmp	0x40087c <.text+0x57c>
               	movq	0x38(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movq	0x30(%rsp), %rbx
               	cmpq	%r14, %rbx
               	setl	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4009a5 <.text+0x6a5>
               	jmp	0x40095a <.text+0x65a>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4008fb <.text+0x5fb>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x20(%rsp)
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0x28(%rsp)
               	jmp	0x4009aa <.text+0x6aa>
               	leaq	0xf7f7(%rip), %rbx      # 0x410158
               	movl	$0x65, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf863(%rip), %rbx      # 0x4101e4
               	movl	$0x54, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x400c1d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x4009a5 <.text+0x6a5>
               	jmp	0x40092b <.text+0x62b>
               	movq	0x20(%rsp), %rbx
               	movslq	%ebx, %rbx
               	movq	0x28(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	movq	%rbx, %rsi
               	xorq	%r15, %rsi
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rsi, %r15
               	cmpq	$0x0, %r15
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x400a66 <.text+0x766>
               	jmp	0x400a1c <.text+0x71c>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4009aa <.text+0x6aa>
               	leaq	0xf751(%rip), %rsi      # 0x410158
               	movslq	(%rsi), %r14
               	cmpq	$0x0, %r14
               	jne	0x400aa7 <.text+0x7a7>
               	jmp	0x400a6b <.text+0x76b>
               	leaq	0xf735(%rip), %rsi      # 0x410158
               	movl	$0x66, %ebx
               	movl	%ebx, (%rsi)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400317 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf7b8(%rip), %r15      # 0x4101fa
               	movl	$0x5d, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400c1d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	jmp	0x400a66 <.text+0x766>
               	jmp	0x4009f0 <.text+0x6f0>
               	leaq	0xf79e(%rip), %rbx      # 0x410210
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x400c23 <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	0xf6aa(%rip), %rbx      # 0x410158
               	movslq	(%rbx), %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
