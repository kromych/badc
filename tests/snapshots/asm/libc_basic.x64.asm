
libc_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4007f6 <.text+0x136>
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
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400745 <.text+0x85>
               	leaq	0xfa6d(%rip), %r9       # 0x410188
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
               	leaq	0xfa4d(%rip), %rdi      # 0x4101a0
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfa3e(%rip), %rdi      # 0x4101a6
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfa30(%rip), %rdi      # 0x4101ad
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4010e7 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4007c7 <.text+0x107>
               	leaq	0xf9d6(%rip), %r14      # 0x410188
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x4007c7 <.text+0x107>
               	leaq	0xf9ba(%rip), %r12      # 0x410188
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
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xf9bd(%rip), %rbx      # 0x4101d8
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4010ed <strlen>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	0x40085c <.text+0x19c>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf97b(%rip), %r12      # 0x4101de
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4010ed <strlen>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x4008a5 <.text+0x1e5>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf933(%rip), %rbx      # 0x4101df
               	leaq	0xf930(%rip), %r14      # 0x4101e3
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4010f3 <strcmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x4008f8 <.text+0x238>
               	movl	$0x3, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf8e8(%rip), %r12      # 0x4101e7
               	leaq	0xf8e8(%rip), %r15      # 0x4101ee
               	movl	$0x3, %r14d
               	movq	%r12, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4010f9 <strncmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400954 <.text+0x294>
               	movl	$0x4, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf89a(%rip), %rbx      # 0x4101f5
               	movl	$0x6c, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4010ff <strchr>
               	cmpq	$0x0, %rax
               	jne	0x4009a2 <.text+0x2e2>
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
               	movzbq	(%rax), %r12
               	xorq	$0x6c, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x4009ea <.text+0x32a>
               	movl	$0x6, %eax
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
               	leaq	0xf806(%rip), %r12      # 0x4101fb
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x401105 <strcpy>
               	leaq	-0x80(%rbp), %rbx
               	leaq	0xf7f2(%rip), %r14      # 0x4101ff
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40110b <strcat>
               	leaq	-0x80(%rbp), %r15
               	leaq	0xf7de(%rip), %r12      # 0x410203
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4010f3 <strcmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400a6a <.text+0x3aa>
               	movl	$0x7, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rbx
               	leaq	0xf795(%rip), %r14      # 0x41020a
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x401105 <strcpy>
               	leaq	-0x80(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x2, %r15
               	leaq	-0x80(%rbp), %r14
               	movl	$0x5, %r12d
               	movq	%r15, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x401111 <memmove>
               	leaq	-0x80(%rbp), %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %r12
               	xorq	$0x30, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	je	0x400afd <.text+0x43d>
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
               	leaq	-0x80(%rbp), %r12
               	addq	$0x6, %r12
               	movzbq	(%r12), %rax
               	xorq	$0x34, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400b52 <.text+0x492>
               	movl	$0x9, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rbx
               	leaq	0xf6b8(%rip), %r15      # 0x410215
               	movl	$0x7, %r12d
               	leaq	0xf6b4(%rip), %r10      # 0x41021e
               	movq	%r10, 0x28(%rsp)
               	movl	$0x2a, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %r8
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movq	0x28(%rsp), %rcx
               	movb	$0x0, %al
               	callq	0x401117 <sprintf>
               	movslq	%eax, %rax
               	leaq	-0x80(%rbp), %rbx
               	leaq	0xf686(%rip), %r15      # 0x410221
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x4010f3 <strcmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400be0 <.text+0x520>
               	movl	$0xa, %r15d
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
               	movl	$0x10, %r14d
               	leaq	0xf638(%rip), %r15      # 0x410229
               	movl	$0x63, %ebx
               	movq	%r12, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40111d <snprintf>
               	movslq	%eax, %rax
               	leaq	-0x80(%rbp), %r12
               	leaq	0xf615(%rip), %r14      # 0x41022c
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x4010f3 <strcmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400c5c <.text+0x59c>
               	movl	$0xb, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %r15d
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x401123 <isspace>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400ca4 <.text+0x5e4>
               	movl	$0xc, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x35, %r14d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x401129 <isdigit>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400cec <.text+0x62c>
               	movl	$0xd, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x61, %r15d
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x401129 <isdigit>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400d34 <.text+0x674>
               	movl	$0xe, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x51, %r14d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x40112f <isalpha>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400d7c <.text+0x6bc>
               	movl	$0xf, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7a, %r15d
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x401135 <isalnum>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400dc4 <.text+0x704>
               	movl	$0x10, %r15d
               	movq	%r15, %rcx
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
               	callq	0x40113b <toupper>
               	movslq	%eax, %rax
               	cmpq	$0x41, %rax
               	je	0x400e0c <.text+0x74c>
               	movl	$0x11, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5a, %r15d
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x401141 <tolower>
               	movslq	%eax, %rax
               	cmpq	$0x7a, %rax
               	je	0x400e54 <.text+0x794>
               	movl	$0x12, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x66, %r14d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x401147 <isxdigit>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	0x400e9c <.text+0x7dc>
               	movl	$0x13, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf38c(%rip), %r15      # 0x41022f
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x40114d <atoi>
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	0x400ee5 <.text+0x825>
               	movl	$0x14, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf346(%rip), %r14      # 0x410232
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x40114d <atoi>
               	movslq	%eax, %rax
               	cmpq	$-0x11, %rax
               	je	0x400f2e <.text+0x86e>
               	movl	$0x15, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x401153 <abs>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	0x400f7a <.text+0x8ba>
               	movl	$0x16, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
