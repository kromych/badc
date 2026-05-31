
alloca_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400b4e <.text+0x84e>
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
               	callq	0x400e97 <dlsym>
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
               	subq	$0x2050, %rsp           # imm = 0x2050
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x28(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x20, %ebx
               	movq	%rbx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	leaq	-0x28(%rbp), %r10
               	movq	(%r10), %r9
               	subq	%r11, %r9
               	movq	%r9, (%r10)
               	movq	%r9, -0x8(%rbp)
               	movq	-0x8(%rbp), %r12
               	movl	$0x55, %r14d
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400e9d <memset>
               	xorq	%rax, %rax
               	movl	%eax, -0x10(%rbp)
               	jmp	0x4004a2 <.text+0x1a2>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x20, %rax
               	jge	0x4004ff <.text+0x1ff>
               	jmp	0x4004ce <.text+0x1ce>
               	leaq	-0x10(%rbp), %r14
               	movslq	(%r14), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%r14)
               	jmp	0x4004a2 <.text+0x1a2>
               	movq	-0x8(%rbp), %rax
               	movslq	-0x10(%rbp), %r12
               	addq	%r12, %rax
               	movzbq	(%rax), %r12
               	xorq	$0x55, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400541 <.text+0x241>
               	jmp	0x40051f <.text+0x21f>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	retq
               	jmp	0x4004b8 <.text+0x1b8>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2020, %rsp           # imm = 0x2020
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, (%r10)
               	movslq	%edi, %r11
               	movl	%r11d, 0x10(%rbp)
               	movslq	0x10(%rbp), %r9
               	shlq	$0x2, %r9
               	movslq	%r9d, %r9
               	movq	%r9, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r11
               	subq	%r10, %r11
               	movq	%r11, (%rax)
               	movq	%r11, -0x8(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x18(%rbp)
               	movl	%r9d, -0x10(%rbp)
               	jmp	0x4005ab <.text+0x2ab>
               	movslq	-0x10(%rbp), %r9
               	movslq	0x10(%rbp), %r11
               	cmpq	%r11, %r9
               	jge	0x400608 <.text+0x308>
               	jmp	0x4005d7 <.text+0x2d7>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	0x4005ab <.text+0x2ab>
               	movq	-0x8(%rbp), %r9
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %r11
               	shlq	$0x2, %r11
               	addq	%r11, %r9
               	movl	$0x7, %r11d
               	imulq	%r11, %r8
               	movslq	%r8d, %r8
               	subq	$0x3, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r9)
               	jmp	0x4005c1 <.text+0x2c1>
               	xorq	%r8, %r8
               	movl	%r8d, -0x10(%rbp)
               	jmp	0x400614 <.text+0x314>
               	movslq	-0x10(%rbp), %r8
               	movslq	0x10(%rbp), %r11
               	cmpq	%r11, %r8
               	jge	0x400664 <.text+0x364>
               	jmp	0x400640 <.text+0x340>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x400614 <.text+0x314>
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r9
               	movq	-0x8(%rbp), %r11
               	movslq	-0x10(%rbp), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r11
               	movslq	(%r11), %rdi
               	addq	%rdi, %r9
               	movl	%r9d, (%r8)
               	jmp	0x40062a <.text+0x32a>
               	movslq	-0x18(%rbp), %rax
               	addq	$0x2020, %rsp           # imm = 0x2020
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2060, %rsp           # imm = 0x2060
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x30(%rbp), %r10
               	movq	%r10, (%r10)
               	movl	$0x10, %r11d
               	movq	%r11, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %r9
               	subq	%r10, %r9
               	movq	%r9, (%rax)
               	movq	%r9, -0x8(%rbp)
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	leaq	-0x30(%rbp), %r10
               	movq	(%r10), %r8
               	subq	%r11, %r8
               	movq	%r8, (%r10)
               	movq	%r8, -0x10(%rbp)
               	movq	-0x8(%rbp), %r11
               	movq	-0x10(%rbp), %r8
               	cmpq	%r8, %r11
               	jne	0x400721 <.text+0x421>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
               	movq	-0x8(%rbp), %rbx
               	movl	$0x41, %r12d
               	movl	$0x10, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400e9d <memset>
               	movq	-0x10(%rbp), %r15
               	movl	$0x42, %ebx
               	movq	%r15, %rdi
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x400e9d <memset>
               	movq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rbx
               	xorq	$0x41, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x2038(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x4007cf <.text+0x4cf>
               	movq	-0x8(%rbp), %rax
               	addq	$0xf, %rax
               	movzbq	(%rax), %rbx
               	xorq	$0x41, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x2038(%rbp)
               	jmp	0x4007cf <.text+0x4cf>
               	movq	-0x2038(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x40080a <.text+0x50a>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x42, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2040(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40087f <.text+0x57f>
               	movq	-0x10(%rbp), %rbx
               	addq	$0xf, %rbx
               	movzbq	(%rbx), %rax
               	xorq	$0x42, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x2040(%rbp)
               	jmp	0x40087f <.text+0x57f>
               	movq	-0x2040(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x4008ba <.text+0x5ba>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2060, %rsp           # imm = 0x2060
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2020, %rsp           # imm = 0x2020
               	leaq	-0x20(%rbp), %r10
               	movq	%r10, (%r10)
               	movslq	%edi, %r11
               	movl	%r11d, 0x10(%rbp)
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	movl	%r9d, -0x10(%rbp)
               	jmp	0x400917 <.text+0x617>
               	movslq	-0x10(%rbp), %r9
               	movslq	0x10(%rbp), %r11
               	cmpq	%r11, %r9
               	jge	0x400992 <.text+0x692>
               	jmp	0x400943 <.text+0x643>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	0x400917 <.text+0x617>
               	movl	$0x8, %r9d
               	movq	%r9, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	leaq	-0x20(%rbp), %r10
               	movq	(%r10), %r8
               	subq	%r11, %r8
               	movq	%r8, (%r10)
               	movq	%r8, -0x18(%rbp)
               	movq	-0x18(%rbp), %r9
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, (%r9)
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r8
               	movq	-0x18(%rbp), %r9
               	movq	(%r9), %rdi
               	movslq	%edi, %rdi
               	addq	%rdi, %r8
               	movl	%r8d, (%r11)
               	jmp	0x40092d <.text+0x62d>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2020, %rsp           # imm = 0x2020
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2050, %rsp           # imm = 0x2050
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x28(%rbp), %r10
               	movq	%r10, (%r10)
               	movslq	%edi, %r11
               	movl	%r11d, 0x10(%rbp)
               	movl	$0x40, %ebx
               	movq	%rbx, %r10
               	addq	$0xf, %r10
               	andq	$-0x10, %r10
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %r11
               	subq	%r10, %r11
               	movq	%r11, (%rax)
               	movq	%r11, -0x8(%rbp)
               	movq	-0x8(%rbp), %r12
               	movslq	0x10(%rbp), %r14
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400e9d <memset>
               	movl	$0x14, %r15d
               	movq	%r15, %rdi
               	callq	0x4008df <.text+0x5df>
               	movl	%eax, -0x10(%rbp)
               	xorq	%r15, %r15
               	movl	%r15d, -0x18(%rbp)
               	jmp	0x400a41 <.text+0x741>
               	movslq	-0x18(%rbp), %r15
               	cmpq	$0x40, %r15
               	jge	0x400a95 <.text+0x795>
               	jmp	0x400a6d <.text+0x76d>
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %r15
               	addq	$0x1, %r15
               	movl	%r15d, (%rax)
               	jmp	0x400a41 <.text+0x741>
               	movq	-0x8(%rbp), %r15
               	movslq	-0x18(%rbp), %r12
               	addq	%r12, %r15
               	movzbq	(%r15), %r12
               	movslq	0x10(%rbp), %r15
               	andq	$0xff, %r15
               	cmpq	%r15, %r12
               	je	0x400ae2 <.text+0x7e2>
               	jmp	0x400aab <.text+0x7ab>
               	movslq	-0x10(%rbp), %r12
               	cmpq	$0xbe, %r12
               	je	0x400b1e <.text+0x81e>
               	jmp	0x400ae7 <.text+0x7e7>
               	movabsq	$-0x1, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	jmp	0x400a57 <.text+0x757>
               	movabsq	$-0x2, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x2050, %rsp           # imm = 0x2050
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	callq	0x400436 <.text+0x136>
               	cmpq	$0x0, %rax
               	je	0x400bb9 <.text+0x8b9>
               	leaq	0xf5d3(%rip), %rbx      # 0x410158
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x400ea3 <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %r12d
               	movq	%r12, %rdi
               	callq	0x400546 <.text+0x246>
               	cmpq	$0x11d, %rax            # imm = 0x11D
               	je	0x400c24 <.text+0x924>
               	leaq	0xf58a(%rip), %rbx      # 0x410165
               	movl	$0xa, %r12d
               	movq	%r12, %rdi
               	callq	0x400546 <.text+0x246>
               	movq	%rax, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400ea3 <printf>
               	movslq	%eax, %rax
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x40067c <.text+0x37c>
               	cmpq	$0x0, %rax
               	je	0x400c71 <.text+0x971>
               	leaq	0xf53a(%rip), %r14      # 0x410177
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x400ea3 <printf>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x32, %r12d
               	movq	%r12, %rdi
               	callq	0x4008df <.text+0x5df>
               	cmpq	$0x4c9, %rax            # imm = 0x4C9
               	je	0x400cdb <.text+0x9db>
               	leaq	0xf4f3(%rip), %r14      # 0x410186
               	movl	$0x32, %r12d
               	movq	%r12, %rdi
               	callq	0x4008df <.text+0x5df>
               	movq	%rax, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400ea3 <printf>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x33, %r12d
               	movq	%r12, %rdi
               	callq	0x4009aa <.text+0x6aa>
               	cmpq	$0x0, %rax
               	je	0x400d31 <.text+0xa31>
               	leaq	0xf49a(%rip), %r15      # 0x410197
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x400ea3 <printf>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
