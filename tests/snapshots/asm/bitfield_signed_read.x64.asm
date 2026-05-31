
bitfield_signed_read.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	movq	%r9, %r8
               	andq	$-0x4, %r8
               	movabsq	$-0x1, %r9
               	movq	%r9, %rdi
               	andq	$0x3, %rdi
               	movq	%r8, %r9
               	orq	%rdi, %r9
               	movw	%r9w, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %r9
               	movq	%r9, %r11
               	andq	$-0xd, %r11
               	movl	$0x1, %r9d
               	movq	%r9, %r8
               	andq	$0x3, %r8
               	movq	%r8, %r9
               	shlq	$0x2, %r9
               	movq	%r11, %r8
               	orq	%r9, %r8
               	movw	%r8w, (%rdi)
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %r8
               	movq	%r8, %rdi
               	andq	$-0xfff1, %rdi          # imm = 0xFFFF000F
               	movabsq	$-0x800, %r8            # imm = 0xF800
               	movq	%r8, %r11
               	andq	$0xfff, %r11            # imm = 0xFFF
               	movq	%r11, %r8
               	shlq	$0x4, %r8
               	movq	%rdi, %r11
               	orq	%r8, %r11
               	movw	%r11w, (%r9)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %r11
               	movq	%r11, %r8
               	andq	$0x3, %r8
               	movq	%r8, %r11
               	shlq	$0x3e, %r11
               	movq	%r11, %r8
               	sarq	$0x3e, %r8
               	cmpq	$-0x1, %r8
               	je	0x400317 <.text+0xf7>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %rax
               	movq	%rax, %r11
               	sarq	$0x2, %r11
               	movq	%r11, %rax
               	andq	$0x3, %rax
               	movq	%rax, %r11
               	shlq	$0x3e, %r11
               	movq	%r11, %rax
               	sarq	$0x3e, %rax
               	cmpq	$0x1, %rax
               	je	0x400359 <.text+0x139>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %rax
               	movq	%rax, %r11
               	sarq	$0x4, %r11
               	movq	%r11, %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	movq	%rax, %r11
               	shlq	$0x34, %r11
               	movq	%r11, %rax
               	sarq	$0x34, %rax
               	cmpq	$-0x800, %rax           # imm = 0xF800
               	je	0x40039b <.text+0x17b>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %rax
               	movq	%rax, %r11
               	andq	$0x3, %r11
               	movq	%r11, %rax
               	shlq	$0x3e, %rax
               	movq	%rax, %r11
               	sarq	$0x3e, %r11
               	movq	%r11, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	0x4003e3 <.text+0x1c3>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %eax
               	movq	%rax, %r9
               	andq	$-0x8, %r9
               	movabsq	$-0x4, %rax
               	movq	%rax, %rdi
               	andq	$0x7, %rdi
               	movq	%r9, %rax
               	orq	%rdi, %rax
               	movl	%eax, (%r11)
               	leaq	-0x10(%rbp), %rdi
               	movl	(%rdi), %eax
               	movq	%rax, %r11
               	andq	$-0x7f9, %r11           # imm = 0xF807
               	movabsq	$-0x80, %rax
               	movq	%rax, %r9
               	andq	$0xff, %r9
               	movq	%r9, %rax
               	shlq	$0x3, %rax
               	movq	%r11, %r9
               	orq	%rax, %r9
               	movl	%r9d, (%rdi)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	movabsq	$-0xfffff801, %rdi      # imm = 0xFFFFFFFF000007FF
               	andq	%r9, %rdi
               	movabsq	$-0x1, %r9
               	movq	%r9, %r11
               	andq	$0x1fffff, %r11         # imm = 0x1FFFFF
               	movq	%r11, %r9
               	shlq	$0xb, %r9
               	movq	%rdi, %r11
               	orq	%r9, %r11
               	movl	%r11d, (%rax)
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %r11d
               	movq	%r11, %r9
               	andq	$0x7, %r9
               	movq	%r9, %r11
               	shlq	$0x3d, %r11
               	movq	%r11, %r9
               	sarq	$0x3d, %r9
               	cmpq	$-0x4, %r9
               	je	0x4004b7 <.text+0x297>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %eax
               	movq	%rax, %r11
               	sarq	$0x3, %r11
               	movq	%r11, %rax
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	cmpq	$-0x80, %rax
               	je	0x4004ee <.text+0x2ce>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %eax
               	movq	%rax, %r11
               	sarq	$0xb, %r11
               	movq	%r11, %rax
               	andq	$0x1fffff, %rax         # imm = 0x1FFFFF
               	movq	%rax, %r11
               	shlq	$0x2b, %r11
               	movq	%r11, %rax
               	sarq	$0x2b, %rax
               	cmpq	$-0x1, %rax
               	je	0x40052f <.text+0x30f>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %eax
               	movq	%rax, %r11
               	andq	$0x7, %r11
               	movq	%r11, %rax
               	shlq	$0x3d, %rax
               	movq	%rax, %r11
               	sarq	$0x3d, %r11
               	cmpq	$0x0, %r11
               	jle	0x40056d <.text+0x34d>
               	movl	$0x18, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r11d
               	movq	%r11, %rax
               	sarq	$0xb, %rax
               	movq	%rax, %r11
               	andq	$0x1fffff, %r11         # imm = 0x1FFFFF
               	movq	%r11, %rax
               	shlq	$0x2b, %rax
               	movq	%rax, %r11
               	sarq	$0x2b, %r11
               	cmpq	$0x0, %r11
               	jl	0x4005b2 <.text+0x392>
               	movl	$0x19, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %r11d
               	movq	%r11, %r9
               	andq	$-0x1000, %r9           # imm = 0xF000
               	movl	$0x7, %r11d
               	movq	%r11, %rdi
               	andq	$0xfff, %rdi            # imm = 0xFFF
               	movq	%r9, %r11
               	orq	%rdi, %r11
               	movl	%r11d, (%rax)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rdi, %r11
               	addq	$0x4, %r11
               	movzwq	(%r11), %rdi
               	movq	%rdi, %rax
               	andq	$-0x4, %rax
               	movabsq	$-0x1, %rdi
               	movq	%rdi, %r9
               	andq	$0x3, %r9
               	movq	%rax, %rdi
               	orq	%r9, %rdi
               	movw	%di, (%r11)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rdi
               	addq	$0x4, %rdi
               	movzwq	(%rdi), %r9
               	movq	%r9, %r11
               	andq	$-0xd, %r11
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	andq	$0x3, %rax
               	movq	%rax, %r9
               	shlq	$0x2, %r9
               	movq	%r11, %rax
               	orq	%r9, %rax
               	movw	%ax, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movl	(%r9), %eax
               	movq	%rax, %r9
               	andq	$0xfff, %r9             # imm = 0xFFF
               	cmpq	$0x7, %r9
               	je	0x400682 <.text+0x462>
               	movl	$0x1f, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r9
               	addq	$0x4, %r9
               	movzwq	(%r9), %rax
               	movq	%rax, %r9
               	andq	$0x3, %r9
               	movq	%r9, %rax
               	shlq	$0x3e, %rax
               	movq	%rax, %r9
               	sarq	$0x3e, %r9
               	cmpq	$-0x1, %r9
               	je	0x4006cb <.text+0x4ab>
               	movl	$0x20, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r9
               	addq	$0x4, %r9
               	movzwq	(%r9), %rax
               	movq	%rax, %r9
               	sarq	$0x2, %r9
               	movq	%r9, %rax
               	andq	$0x3, %rax
               	movq	%rax, %r9
               	shlq	$0x3e, %r9
               	movq	%r9, %rax
               	sarq	$0x3e, %rax
               	cmpq	$0x1, %rax
               	je	0x400717 <.text+0x4f7>
               	movl	$0x21, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %r9d
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x4, %rdi
               	movzwq	(%rdi), %rax
               	movq	%rax, %rdi
               	andq	$0x3, %rdi
               	movq	%rdi, %rax
               	shlq	$0x3e, %rax
               	movq	%rax, %rdi
               	sarq	$0x3e, %rdi
               	movslq	%r9d, %rax
               	movq	%rdi, %r9
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x5, %r9
               	je	0x400772 <.text+0x552>
               	movl	$0x22, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
