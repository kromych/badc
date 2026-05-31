
typedef_array_comma_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x210, %rsp            # imm = 0x210
               	leaq	0xfe87(%rip), %r11      # 0x4100d0
               	movq	(%r11), %r9
               	cmpq	$0x0, %r9
               	je	0x400267 <.text+0x47>
               	movl	$0x1, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe62(%rip), %r9       # 0x4100d0
               	addq	$0x78, %r9
               	movq	(%r9), %rax
               	cmpq	$0x0, %rax
               	je	0x400297 <.text+0x77>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfeb2(%rip), %rax      # 0x410150
               	movq	(%rax), %r9
               	cmpq	$0x1, %r9
               	je	0x4002bc <.text+0x9c>
               	movl	$0x3, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe8d(%rip), %r9       # 0x410150
               	addq	$0x8, %r9
               	movq	(%r9), %rax
               	cmpq	$0x0, %rax
               	je	0x4002ec <.text+0xcc>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe5d(%rip), %rax      # 0x410150
               	addq	$0x78, %rax
               	movq	(%rax), %r9
               	cmpq	$0x0, %r9
               	je	0x400318 <.text+0xf8>
               	movl	$0x5, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfeb1(%rip), %r9       # 0x4101d0
               	movq	(%r9), %rax
               	cmpq	$0x0, %rax
               	je	0x400341 <.text+0x121>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe88(%rip), %rax      # 0x4101d0
               	addq	$0x10, %rax
               	movq	(%rax), %r9
               	cmpq	$0x7, %r9
               	je	0x40036d <.text+0x14d>
               	movl	$0x7, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe5c(%rip), %r9       # 0x4101d0
               	addq	$0x78, %r9
               	movq	(%r9), %rax
               	cmpq	$0x0, %rax
               	je	0x40039d <.text+0x17d>
               	movl	$0x8, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0x40, %eax
               	movslq	%eax, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0x200, %rax            # imm = 0x200
               	je	0x4003cb <.text+0x1ab>
               	movl	$0x9, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0x40, %eax
               	movslq	%eax, %rax
               	shlq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0x200, %rax            # imm = 0x200
               	je	0x4003f9 <.text+0x1d9>
               	movl	$0xa, %r9d
               	movq	%r9, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfe50(%rip), %rax      # 0x410250
               	addq	$0x138, %rax            # imm = 0x138
               	movl	$0x2a, %r9d
               	movq	%r9, (%rax)
               	leaq	0x10039(%rip), %r8      # 0x410450
               	addq	$0x1f8, %r8             # imm = 0x1F8
               	movabsq	$-0x1, %r9
               	movq	%r9, (%r8)
               	movq	(%rax), %rdi
               	cmpq	$0x2a, %rdi
               	je	0x400449 <.text+0x229>
               	movl	$0xb, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0x10000(%rip), %rdi     # 0x410450
               	addq	$0x1f8, %rdi            # imm = 0x1F8
               	movq	(%rdi), %rax
               	cmpq	$-0x1, %rax
               	je	0x400478 <.text+0x258>
               	movl	$0xc, %edi
               	movq	%rdi, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xfdd1(%rip), %rax      # 0x410250
               	movq	(%rax), %rdi
               	cmpq	$0x0, %rdi
               	je	0x40049d <.text+0x27d>
               	movl	$0xd, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	0xffac(%rip), %rdi      # 0x410450
               	movq	(%rdi), %rax
               	cmpq	$0x0, %rax
               	je	0x4004c5 <.text+0x2a5>
               	movl	$0xe, %edi
               	movq	%rdi, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %rax
               	addq	$0x200, %rax            # imm = 0x200
               	movl	$0x63, %edi
               	movl	%edi, (%rax)
               	leaq	-0x208(%rbp), %r9
               	addq	$0x200, %r9             # imm = 0x200
               	movslq	(%r9), %rdi
               	cmpq	$0x63, %rdi
               	je	0x400506 <.text+0x2e6>
               	movl	$0xf, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0x40, %edi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	addq	$0x4, %rdi
               	movslq	%edi, %rdi
               	cmpq	$0x208, %rdi            # imm = 0x208
               	jle	0x400537 <.text+0x317>
               	movl	$0x10, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
