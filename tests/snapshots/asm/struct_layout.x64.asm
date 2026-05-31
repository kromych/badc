
struct_layout.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40030b <.text+0x8b>
               	leaq	0xfe1a(%rip), %rdi      # 0x4100f8
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
               	leaq	0xfdf7(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfde5(%rip), %rsi      # 0x410116
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfdd4(%rip), %r9       # 0x41011d
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
               	callq	0x400f67 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40039c <.text+0x11c>
               	leaq	0xfd74(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40039c <.text+0x11c>
               	leaq	0xfd55(%rip), %r12      # 0x4100f8
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
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4003e6 <.text+0x166>
               	movl	$0x1, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400403 <.text+0x183>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x40042a <.text+0x1aa>
               	movl	$0x3, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x400451 <.text+0x1d1>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x10, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x10, %r11
               	je	0x400478 <.text+0x1f8>
               	movl	$0x5, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	0x40049f <.text+0x21f>
               	movl	$0x6, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1a, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1a, %r11
               	je	0x4004c6 <.text+0x246>
               	movl	$0x7, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x20, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x20, %r11
               	je	0x4004ed <.text+0x26d>
               	movl	$0x8, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400507 <.text+0x287>
               	movl	$0xa, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400520 <.text+0x2a0>
               	movl	$0xb, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	0x400543 <.text+0x2c3>
               	movl	$0xc, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	0x400566 <.text+0x2e6>
               	movl	$0xd, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	0x400589 <.text+0x309>
               	movl	$0xe, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40059f <.text+0x31f>
               	movl	$0x14, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4005bc <.text+0x33c>
               	movl	$0x15, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x4005e3 <.text+0x363>
               	movl	$0x16, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x40060a <.text+0x38a>
               	movl	$0x17, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400624 <.text+0x3a4>
               	movl	$0x1e, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x40063d <.text+0x3bd>
               	movl	$0x1f, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	0x400660 <.text+0x3e0>
               	movl	$0x20, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	0x400683 <.text+0x403>
               	movl	$0x21, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400699 <.text+0x419>
               	movl	$0x28, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4006b6 <.text+0x436>
               	movl	$0x29, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x4006dd <.text+0x45d>
               	movl	$0x2a, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x20, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x20, %r11
               	je	0x400704 <.text+0x484>
               	movl	$0x2b, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x40071e <.text+0x49e>
               	movl	$0x32, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400738 <.text+0x4b8>
               	movl	$0x33, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400751 <.text+0x4d1>
               	movl	$0x34, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x24, %rax
               	movslq	%eax, %rax
               	cmpq	$0x24, %rax
               	je	0x400774 <.text+0x4f4>
               	movl	$0x35, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40078a <.text+0x50a>
               	movl	$0x3c, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4007a0 <.text+0x520>
               	movl	$0x3d, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4007bd <.text+0x53d>
               	movl	$0x3e, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x4007e4 <.text+0x564>
               	movl	$0x3f, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	0x40080b <.text+0x58b>
               	movl	$0x40, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400825 <.text+0x5a5>
               	movl	$0x46, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x40083e <.text+0x5be>
               	movl	$0x47, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	0x400861 <.text+0x5e1>
               	movl	$0x48, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x5, %rax
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	0x400884 <.text+0x604>
               	movl	$0x49, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x6, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	0x4008a7 <.text+0x627>
               	movl	$0x4a, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0xe, %rax
               	movslq	%eax, %rax
               	cmpq	$0xe, %rax
               	je	0x4008ca <.text+0x64a>
               	movl	$0x4b, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	0x4008ed <.text+0x66d>
               	movl	$0x4c, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x11, %rax
               	movslq	%eax, %rax
               	cmpq	$0x11, %rax
               	je	0x400910 <.text+0x690>
               	movl	$0x4d, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400926 <.text+0x6a6>
               	movl	$0x50, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400943 <.text+0x6c3>
               	movl	$0x51, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x40096a <.text+0x6ea>
               	movl	$0x52, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1a, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1a, %r11
               	je	0x400991 <.text+0x711>
               	movl	$0x53, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x4009ab <.text+0x72b>
               	movl	$0x5a, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x4009c4 <.text+0x744>
               	movl	$0x5b, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	0x4009e7 <.text+0x767>
               	movl	$0x5c, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x6, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	0x400a0a <.text+0x78a>
               	movl	$0x5d, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	je	0x400a2d <.text+0x7ad>
               	movl	$0x5e, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	0x400a50 <.text+0x7d0>
               	movl	$0x5f, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x12, %rax
               	movslq	%eax, %rax
               	cmpq	$0x12, %rax
               	je	0x400a73 <.text+0x7f3>
               	movl	$0x60, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	cmpq	$0x14, %rax
               	je	0x400a96 <.text+0x816>
               	movl	$0x61, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400aac <.text+0x82c>
               	movl	$0x64, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400ac9 <.text+0x849>
               	movl	$0x65, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x400af0 <.text+0x870>
               	movl	$0x66, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x400b17 <.text+0x897>
               	movl	$0x67, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0xc, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xc, %r11
               	je	0x400b3e <.text+0x8be>
               	movl	$0x68, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x14, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x14, %r11
               	je	0x400b65 <.text+0x8e5>
               	movl	$0x69, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x16, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x16, %r11
               	je	0x400b8c <.text+0x90c>
               	movl	$0x6a, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	0x400bb3 <.text+0x933>
               	movl	$0x6b, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400bcd <.text+0x94d>
               	movl	$0x6e, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x400bf4 <.text+0x974>
               	movl	$0x6f, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400c0e <.text+0x98e>
               	movl	$0x78, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x400c35 <.text+0x9b5>
               	movl	$0x79, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400c4f <.text+0x9cf>
               	movl	$0x82, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x400c76 <.text+0x9f6>
               	movl	$0x83, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400c90 <.text+0xa10>
               	movl	$0x8c, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400ca9 <.text+0xa29>
               	movl	$0x8d, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	0x400ccc <.text+0xa4c>
               	movl	$0x8e, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	je	0x400cef <.text+0xa6f>
               	movl	$0x8f, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400d05 <.text+0xa85>
               	movl	$0x96, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400d1b <.text+0xa9b>
               	movl	$0x97, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400d38 <.text+0xab8>
               	movl	$0x98, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x400d5f <.text+0xadf>
               	movl	$0x99, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %r11
               	addq	$0x9, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x9, %r11
               	je	0x400d86 <.text+0xb06>
               	movl	$0x9a, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x400da0 <.text+0xb20>
               	movl	$0xa0, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	0x400db9 <.text+0xb39>
               	movl	$0xa1, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	0x400ddc <.text+0xb5c>
               	movl	$0xa2, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	je	0x400dff <.text+0xb7f>
               	movl	$0xa3, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0xc, %rax
               	movslq	%eax, %rax
               	cmpq	$0xc, %rax
               	je	0x400e22 <.text+0xba2>
               	movl	$0xa4, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
