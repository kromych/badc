
struct_layout.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003b6 <.text+0x136>
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
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400305 <.text+0x85>
               	leaq	0xfe1d(%rip), %r9       # 0x4100f8
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
               	leaq	0xfdfd(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdee(%rip), %rdi      # 0x410116
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfde0(%rip), %rdi      # 0x41011d
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400e17 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400387 <.text+0x107>
               	leaq	0xfd86(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x400387 <.text+0x107>
               	leaq	0xfd6a(%rip), %r12      # 0x4100f8
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
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4003cc <.text+0x14c>
               	movl	$0x1, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4003e5 <.text+0x165>
               	movl	$0x2, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x400405 <.text+0x185>
               	movl	$0x3, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x400425 <.text+0x1a5>
               	movl	$0x4, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x10, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x10, %r11
               	je	0x400445 <.text+0x1c5>
               	movl	$0x5, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	0x400465 <.text+0x1e5>
               	movl	$0x6, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1a, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1a, %r11
               	je	0x400485 <.text+0x205>
               	movl	$0x7, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x20, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x20, %r11
               	je	0x4004a5 <.text+0x225>
               	movl	$0x8, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4004bb <.text+0x23b>
               	movl	$0xa, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4004d4 <.text+0x254>
               	movl	$0xb, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x4004f4 <.text+0x274>
               	movl	$0xc, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x2, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x2, %r11
               	je	0x400514 <.text+0x294>
               	movl	$0xd, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x3, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x3, %r11
               	je	0x400534 <.text+0x2b4>
               	movl	$0xe, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40054a <.text+0x2ca>
               	movl	$0x14, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400563 <.text+0x2e3>
               	movl	$0x15, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x400583 <.text+0x303>
               	movl	$0x16, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x4005a3 <.text+0x323>
               	movl	$0x17, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4005b9 <.text+0x339>
               	movl	$0x1e, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4005d2 <.text+0x352>
               	movl	$0x1f, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x4005f2 <.text+0x372>
               	movl	$0x20, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x10, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x10, %r11
               	je	0x400612 <.text+0x392>
               	movl	$0x21, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400628 <.text+0x3a8>
               	movl	$0x28, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400641 <.text+0x3c1>
               	movl	$0x29, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x400661 <.text+0x3e1>
               	movl	$0x2a, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x20, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x20, %r11
               	je	0x400681 <.text+0x401>
               	movl	$0x2b, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400697 <.text+0x417>
               	movl	$0x32, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4006ad <.text+0x42d>
               	movl	$0x33, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4006c6 <.text+0x446>
               	movl	$0x34, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x24, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x24, %r11
               	je	0x4006e6 <.text+0x466>
               	movl	$0x35, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4006fc <.text+0x47c>
               	movl	$0x3c, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400712 <.text+0x492>
               	movl	$0x3d, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x40072b <.text+0x4ab>
               	movl	$0x3e, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x40074b <.text+0x4cb>
               	movl	$0x3f, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	0x40076b <.text+0x4eb>
               	movl	$0x40, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400781 <.text+0x501>
               	movl	$0x46, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x40079a <.text+0x51a>
               	movl	$0x47, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x4007ba <.text+0x53a>
               	movl	$0x48, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x5, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x5, %r11
               	je	0x4007da <.text+0x55a>
               	movl	$0x49, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x6, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x6, %r11
               	je	0x4007fa <.text+0x57a>
               	movl	$0x4a, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0xe, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xe, %r11
               	je	0x40081a <.text+0x59a>
               	movl	$0x4b, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x10, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x10, %r11
               	je	0x40083a <.text+0x5ba>
               	movl	$0x4c, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x11, %r11
               	je	0x40085a <.text+0x5da>
               	movl	$0x4d, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400870 <.text+0x5f0>
               	movl	$0x50, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400889 <.text+0x609>
               	movl	$0x51, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x4008a9 <.text+0x629>
               	movl	$0x52, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1a, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1a, %r11
               	je	0x4008c9 <.text+0x649>
               	movl	$0x53, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4008df <.text+0x65f>
               	movl	$0x5a, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4008f8 <.text+0x678>
               	movl	$0x5b, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x2, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x2, %r11
               	je	0x400918 <.text+0x698>
               	movl	$0x5c, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x6, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x6, %r11
               	je	0x400938 <.text+0x6b8>
               	movl	$0x5d, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x400958 <.text+0x6d8>
               	movl	$0x5e, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x10, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x10, %r11
               	je	0x400978 <.text+0x6f8>
               	movl	$0x5f, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x12, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x12, %r11
               	je	0x400998 <.text+0x718>
               	movl	$0x60, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x14, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x14, %r11
               	je	0x4009b8 <.text+0x738>
               	movl	$0x61, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4009ce <.text+0x74e>
               	movl	$0x64, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x4009e7 <.text+0x767>
               	movl	$0x65, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x400a07 <.text+0x787>
               	movl	$0x66, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x400a27 <.text+0x7a7>
               	movl	$0x67, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0xc, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xc, %r11
               	je	0x400a47 <.text+0x7c7>
               	movl	$0x68, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x14, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x14, %r11
               	je	0x400a67 <.text+0x7e7>
               	movl	$0x69, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x16, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x16, %r11
               	je	0x400a87 <.text+0x807>
               	movl	$0x6a, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	0x400aa7 <.text+0x827>
               	movl	$0x6b, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400abd <.text+0x83d>
               	movl	$0x6e, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x400add <.text+0x85d>
               	movl	$0x6f, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400af3 <.text+0x873>
               	movl	$0x78, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x400b13 <.text+0x893>
               	movl	$0x79, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400b29 <.text+0x8a9>
               	movl	$0x82, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x400b49 <.text+0x8c9>
               	movl	$0x83, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400b5f <.text+0x8df>
               	movl	$0x8c, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400b78 <.text+0x8f8>
               	movl	$0x8d, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	0x400b98 <.text+0x918>
               	movl	$0x8e, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	0x400bb8 <.text+0x938>
               	movl	$0x8f, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400bce <.text+0x94e>
               	movl	$0x96, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400be4 <.text+0x964>
               	movl	$0x97, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400bfd <.text+0x97d>
               	movl	$0x98, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	0x400c1d <.text+0x99d>
               	movl	$0x99, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x9, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x9, %r11
               	je	0x400c3d <.text+0x9bd>
               	movl	$0x9a, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400c53 <.text+0x9d3>
               	movl	$0xa0, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	0x400c6c <.text+0x9ec>
               	movl	$0xa1, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x2, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x2, %r11
               	je	0x400c8c <.text+0xa0c>
               	movl	$0xa2, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0xa, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xa, %r11
               	je	0x400cac <.text+0xa2c>
               	movl	$0xa3, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0xc, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xc, %r11
               	je	0x400ccc <.text+0xa4c>
               	movl	$0xa4, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
