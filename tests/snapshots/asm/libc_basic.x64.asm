
libc_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40080d <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfaa1(%rip)           # 0x410178
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfa8e(%rip), %r9       # 0x410188
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40074b <.text+0x8b>
               	leaq	0xfa6a(%rip), %rdi      # 0x410188
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
               	leaq	0xfa47(%rip), %rdi      # 0x4101a0
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfa35(%rip), %rsi      # 0x4101a6
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfa24(%rip), %r9       # 0x4101ad
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
               	callq	0x4010f7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4007d9 <.text+0x119>
               	leaq	0xf9c7(%rip), %r14      # 0x410188
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4007d9 <.text+0x119>
               	leaq	0xf9a8(%rip), %r12      # 0x410188
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
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xf9a6(%rip), %rbx      # 0x4101d8
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4010fd <strlen>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	0x400873 <.text+0x1b3>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf964(%rip), %r12      # 0x4101de
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4010fd <strlen>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x4008bb <.text+0x1fb>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf91d(%rip), %rbx      # 0x4101df
               	leaq	0xf91a(%rip), %r12      # 0x4101e3
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x401103 <strcmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x40090d <.text+0x24d>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf8d3(%rip), %r14      # 0x4101e7
               	leaq	0xf8d3(%rip), %r12      # 0x4101ee
               	movl	$0x3, %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x401109 <strncmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400968 <.text+0x2a8>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf886(%rip), %rbx      # 0x4101f5
               	movl	$0x6c, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40110f <strchr>
               	cmpq	$0x0, %rax
               	jne	0x4009b6 <.text+0x2f6>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rax), %r15
               	movq	%r15, %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	cmpq	$0x0, %r15
               	je	0x400a02 <.text+0x342>
               	movl	$0x6, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r12
               	leaq	0xf7ee(%rip), %r14      # 0x4101fb
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x401115 <strcpy>
               	leaq	-0x80(%rbp), %rbx
               	leaq	0xf7da(%rip), %r15      # 0x4101ff
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40111b <strcat>
               	leaq	-0x80(%rbp), %r12
               	leaq	0xf7c6(%rip), %r14      # 0x410203
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x401103 <strcmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400a81 <.text+0x3c1>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rbx
               	leaq	0xf77e(%rip), %r14      # 0x41020a
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x401115 <strcpy>
               	leaq	-0x80(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x2, %r12
               	leaq	-0x80(%rbp), %r14
               	movl	$0x5, %r15d
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x401121 <memmove>
               	leaq	-0x80(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x2, %r15
               	movzbq	(%r15), %rax
               	movq	%rax, %r15
               	xorq	$0x30, %r15
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r15, %rax
               	cmpq	$0x0, %rax
               	je	0x400b19 <.text+0x459>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r15
               	movq	%r15, %rax
               	addq	$0x6, %rax
               	movzbq	(%rax), %r15
               	movq	%r15, %rax
               	xorq	$0x34, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	cmpq	$0x0, %r15
               	je	0x400b73 <.text+0x4b3>
               	movl	$0x9, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rbx
               	leaq	0xf697(%rip), %r12      # 0x410215
               	movl	$0x7, %r15d
               	leaq	0xf693(%rip), %r10      # 0x41021e
               	movq	%r10, 0x28(%rsp)
               	movl	$0x2a, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %r8
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movq	0x28(%rsp), %rcx
               	movb	$0x0, %al
               	callq	0x401127 <sprintf>
               	movslq	%eax, %rax
               	leaq	-0x80(%rbp), %rbx
               	leaq	0xf665(%rip), %r12      # 0x410221
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x401103 <strcmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400c00 <.text+0x540>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r15
               	movl	$0x10, %r12d
               	leaq	0xf618(%rip), %r14      # 0x410229
               	movl	$0x63, %ebx
               	movq	%r15, %rdi
               	movq	%rbx, %rcx
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40112d <snprintf>
               	movslq	%eax, %rax
               	leaq	-0x80(%rbp), %r15
               	leaq	0xf5f5(%rip), %r12      # 0x41022c
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x401103 <strcmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400c7b <.text+0x5bb>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %r14d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x401133 <isspace>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400cc2 <.text+0x602>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x35, %r12d
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x401139 <isdigit>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400d09 <.text+0x649>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x61, %r14d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x401139 <isdigit>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400d51 <.text+0x691>
               	movl	$0xe, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x51, %r12d
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x40113f <isalpha>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400d98 <.text+0x6d8>
               	movl	$0xf, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7a, %r14d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x401145 <isalnum>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400ddf <.text+0x71f>
               	movl	$0x10, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x61, %r12d
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x40114b <toupper>
               	movslq	%eax, %rax
               	cmpq	$0x41, %rax
               	je	0x400e26 <.text+0x766>
               	movl	$0x11, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5a, %r14d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x401151 <tolower>
               	movslq	%eax, %rax
               	cmpq	$0x7a, %rax
               	je	0x400e6d <.text+0x7ad>
               	movl	$0x12, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x66, %r12d
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x401157 <isxdigit>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400eb4 <.text+0x7f4>
               	movl	$0x13, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf374(%rip), %r14      # 0x41022f
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x40115d <atoi>
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	0x400efc <.text+0x83c>
               	movl	$0x14, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf32f(%rip), %r12      # 0x410232
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x40115d <atoi>
               	movslq	%eax, %rax
               	cmpq	$-0x11, %rax
               	je	0x400f44 <.text+0x884>
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x401163 <abs>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	0x400f8f <.text+0x8cf>
               	movl	$0x16, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
