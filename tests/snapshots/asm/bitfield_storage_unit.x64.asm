
bitfield_storage_unit.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400260 <.text+0x40>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40027e <.text+0x5e>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x40029c <.text+0x7c>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4002ba <.text+0x9a>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	leaq	-0x10(%rbp), %r11
               	movq	%rax, %r8
               	subq	%r11, %r8
               	cmpq	$0x4, %r8
               	je	0x4002ed <.text+0xcd>
               	movl	$0xf, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	leaq	-0x10(%rbp), %r11
               	movq	%rax, %r8
               	subq	%r11, %r8
               	cmpq	$0x8, %r8
               	je	0x400320 <.text+0x100>
               	movl	$0x10, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	movq	%rax, %r8
               	andq	$-0x100, %r8
               	movl	$0xab, %eax
               	movq	%rax, %rdi
               	andq	$0xff, %rdi
               	movq	%r8, %rax
               	orq	%rdi, %rax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %rdi
               	movl	(%rdi), %eax
               	movq	%rax, %r11
               	andq	$-0x101, %r11           # imm = 0xFEFF
               	movl	$0x1, %eax
               	movq	%rax, %r8
               	andq	$0x1, %r8
               	movq	%r8, %rax
               	shlq	$0x8, %rax
               	movq	%r11, %r8
               	orq	%rax, %r8
               	movl	%r8d, (%rdi)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %r8d
               	movabsq	$-0xfffffe01, %rdi      # imm = 0xFFFFFFFF000001FF
               	andq	%r8, %rdi
               	movl	$0x12345, %r8d          # imm = 0x12345
               	movq	%r8, %r11
               	andq	$0x7fffff, %r11         # imm = 0x7FFFFF
               	movq	%r11, %r8
               	shlq	$0x9, %r8
               	movq	%rdi, %r11
               	orq	%r8, %r11
               	movl	%r11d, (%rax)
               	leaq	-0x18(%rbp), %r8
               	movl	(%r8), %r11d
               	movq	%r11, %r8
               	andq	$0xff, %r8
               	cmpq	$0xab, %r8
               	je	0x4003d8 <.text+0x1b8>
               	movl	$0x11, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	movq	%rax, %r11
               	sarq	$0x8, %r11
               	movq	%r11, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	0x40040b <.text+0x1eb>
               	movl	$0x12, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	movq	%rax, %r11
               	sarq	$0x9, %r11
               	movq	%r11, %rax
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	cmpq	$0x12345, %rax          # imm = 0x12345
               	je	0x40043e <.text+0x21e>
               	movl	$0x13, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	(%r11), %eax
               	movq	%rax, %r8
               	andq	$-0x100, %r8
               	movl	$0x55, %eax
               	movq	%rax, %rdi
               	andq	$0xff, %rdi
               	movq	%r8, %rax
               	orq	%rdi, %rax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %rdi
               	movl	(%rdi), %eax
               	movq	%rax, %rdi
               	andq	$0xff, %rdi
               	cmpq	$0x55, %rdi
               	je	0x400495 <.text+0x275>
               	movl	$0x14, %edi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %edi
               	movq	%rdi, %rax
               	sarq	$0x8, %rax
               	movq	%rax, %rdi
               	andq	$0x1, %rdi
               	cmpq	$0x1, %rdi
               	je	0x4004ca <.text+0x2aa>
               	movl	$0x15, %edi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %edi
               	movq	%rdi, %rax
               	sarq	$0x9, %rax
               	movq	%rax, %rdi
               	andq	$0x7fffff, %rdi         # imm = 0x7FFFFF
               	cmpq	$0x12345, %rdi          # imm = 0x12345
               	je	0x4004ff <.text+0x2df>
               	movl	$0x16, %edi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %edi
               	movq	%rdi, %r11
               	andq	$-0x100, %r11
               	movl	$0xff, %edi
               	movq	%rdi, %r8
               	andq	$0xff, %r8
               	movq	%r11, %rdi
               	orq	%r8, %rdi
               	movl	%edi, (%rax)
               	leaq	-0x20(%rbp), %r8
               	movl	(%r8), %edi
               	movq	%rdi, %rax
               	andq	$-0x101, %rax           # imm = 0xFEFF
               	movl	$0x1, %edi
               	movq	%rdi, %r11
               	andq	$0x1, %r11
               	movq	%r11, %rdi
               	shlq	$0x8, %rdi
               	movq	%rax, %r11
               	orq	%rdi, %r11
               	movl	%r11d, (%r8)
               	leaq	-0x20(%rbp), %rdi
               	movl	(%rdi), %r11d
               	movabsq	$-0xfffffe01, %r8       # imm = 0xFFFFFFFF000001FF
               	andq	%r11, %r8
               	movl	$0x7fffff, %r11d        # imm = 0x7FFFFF
               	movq	%r11, %rax
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	movq	%rax, %r11
               	shlq	$0x9, %r11
               	movq	%r8, %rax
               	orq	%r11, %rax
               	movl	%eax, (%rdi)
               	leaq	-0x20(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movl	(%rax), %r11d
               	movq	%r11, %rdi
               	andq	$-0x100, %rdi
               	xorq	%r11, %r11
               	movq	%r11, %r8
               	andq	$0xff, %r8
               	movq	%rdi, %rsi
               	orq	%r8, %rsi
               	movl	%esi, (%rax)
               	leaq	-0x20(%rbp), %r8
               	movq	%r8, %rsi
               	addq	$0x4, %rsi
               	movl	(%rsi), %r8d
               	movq	%r8, %rax
               	andq	$-0x101, %rax           # imm = 0xFEFF
               	movq	%r11, %r8
               	andq	$0x1, %r8
               	movq	%r8, %rdi
               	shlq	$0x8, %rdi
               	movq	%rax, %r8
               	orq	%rdi, %r8
               	movl	%r8d, (%rsi)
               	leaq	-0x20(%rbp), %rdi
               	movq	%rdi, %r8
               	addq	$0x4, %r8
               	movl	(%r8), %edi
               	movabsq	$-0xfffffe01, %rsi      # imm = 0xFFFFFFFF000001FF
               	andq	%rdi, %rsi
               	movq	%r11, %rdi
               	andq	$0x7fffff, %rdi         # imm = 0x7FFFFF
               	movq	%rdi, %r11
               	shlq	$0x9, %r11
               	movq	%rsi, %rdi
               	orq	%r11, %rdi
               	movl	%edi, (%r8)
               	leaq	-0x20(%rbp), %r11
               	movq	%r11, %rdi
               	addq	$0x4, %rdi
               	movl	(%rdi), %r11d
               	movq	%r11, %rdi
               	andq	$0xff, %rdi
               	cmpq	$0x0, %rdi
               	je	0x40065c <.text+0x43c>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movl	(%rax), %r11d
               	movq	%r11, %rax
               	sarq	$0x8, %rax
               	movq	%rax, %r11
               	andq	$0x1, %r11
               	cmpq	$0x0, %r11
               	je	0x40069d <.text+0x47d>
               	movl	$0x18, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movl	(%r11), %eax
               	movq	%rax, %r11
               	sarq	$0x9, %r11
               	movq	%r11, %rax
               	andq	$0x7fffff, %rax         # imm = 0x7FFFFF
               	cmpq	$0x0, %rax
               	je	0x4006da <.text+0x4ba>
               	movl	$0x19, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
