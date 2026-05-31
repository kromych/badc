
bitfield_compound_assignment.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	movq	%r9, %r8
               	andq	$-0x2, %r8
               	xorq	%r9, %r9
               	movq	%r9, %rdi
               	andq	$0x1, %rdi
               	movq	%r8, %rsi
               	orq	%rdi, %rsi
               	movw	%si, (%r11)
               	leaq	-0x8(%rbp), %rdi
               	movzwq	(%rdi), %rsi
               	movq	%rsi, %r11
               	andq	$-0xf, %r11
               	movq	%r9, %rsi
               	andq	$0x7, %rsi
               	movq	%rsi, %r8
               	shlq	$0x1, %r8
               	movq	%r11, %rsi
               	orq	%r8, %rsi
               	movw	%si, (%rdi)
               	leaq	-0x8(%rbp), %r8
               	movzwq	(%r8), %rsi
               	movq	%rsi, %rdi
               	andq	$-0xf1, %rdi
               	movq	%r9, %rsi
               	andq	$0xf, %rsi
               	movq	%rsi, %r11
               	shlq	$0x4, %r11
               	movq	%rdi, %rsi
               	orq	%r11, %rsi
               	movw	%si, (%r8)
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %rsi
               	movq	%rsi, %r8
               	andq	$-0xff01, %r8           # imm = 0xFFFF00FF
               	movq	%r9, %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r9
               	shlq	$0x8, %r9
               	movq	%r8, %rsi
               	orq	%r9, %rsi
               	movw	%si, (%r11)
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rsi
               	movq	%rsi, %r11
               	andq	$-0xf, %r11
               	leaq	-0x8(%rbp), %rsi
               	movzwq	(%rsi), %r8
               	movq	%r8, %rsi
               	sarq	$0x1, %rsi
               	movq	%rsi, %r8
               	andq	$0x7, %r8
               	movq	%r8, %rsi
               	orq	$0x5, %rsi
               	movq	%rsi, %r8
               	andq	$0x7, %r8
               	movq	%r8, %rsi
               	shlq	$0x1, %rsi
               	movq	%r11, %r8
               	orq	%rsi, %r8
               	movw	%r8w, (%r9)
               	leaq	-0x8(%rbp), %rsi
               	movzwq	(%rsi), %r8
               	movq	%r8, %rsi
               	sarq	$0x1, %rsi
               	movq	%rsi, %r8
               	andq	$0x7, %r8
               	cmpq	$0x5, %r8
               	je	0x400375 <.text+0x155>
               	movl	$0xb, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rsi
               	movzwq	(%rsi), %rax
               	movq	%rax, %r9
               	andq	$-0xf, %r9
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r11
               	movq	%r11, %rax
               	sarq	$0x1, %rax
               	movq	%rax, %r11
               	andq	$0x7, %r11
               	movq	%r11, %rax
               	orq	$0x2, %rax
               	movq	%rax, %r11
               	andq	$0x7, %r11
               	movq	%r11, %rax
               	shlq	$0x1, %rax
               	movq	%r9, %r11
               	orq	%rax, %r11
               	movw	%r11w, (%rsi)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r11
               	movq	%r11, %rax
               	sarq	$0x1, %rax
               	movq	%rax, %r11
               	andq	$0x7, %r11
               	cmpq	$0x7, %r11
               	je	0x4003fd <.text+0x1dd>
               	movl	$0xc, %r11d
               	movq	%r11, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r11
               	movq	%r11, %rsi
               	andq	$-0xf, %rsi
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	movq	%r9, %r11
               	sarq	$0x1, %r11
               	movq	%r11, %r9
               	andq	$0x6, %r9
               	movq	%r9, %r11
               	shlq	$0x1, %r11
               	movq	%rsi, %r9
               	orq	%r11, %r9
               	movw	%r9w, (%rax)
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %r9
               	movq	%r9, %r11
               	sarq	$0x1, %r11
               	movq	%r11, %r9
               	andq	$0x7, %r9
               	cmpq	$0x6, %r9
               	je	0x40046d <.text+0x24d>
               	movl	$0xd, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %rax
               	movq	%rax, %r9
               	andq	$-0xf, %r9
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rsi
               	movq	%rsi, %rax
               	sarq	$0x1, %rax
               	movq	%rax, %rsi
               	andq	$0x7, %rsi
               	movq	%rsi, %rax
               	xorq	$0x7, %rax
               	movq	%rax, %rsi
               	andq	$0x7, %rsi
               	movq	%rsi, %rax
               	shlq	$0x1, %rax
               	movq	%r9, %rsi
               	orq	%rax, %rsi
               	movw	%si, (%r11)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rsi
               	movq	%rsi, %rax
               	sarq	$0x1, %rax
               	movq	%rax, %rsi
               	andq	$0x7, %rsi
               	cmpq	$0x1, %rsi
               	je	0x4004f4 <.text+0x2d4>
               	movl	$0xe, %esi
               	movq	%rsi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rsi
               	movq	%rsi, %r11
               	andq	$-0x2, %r11
               	movl	$0x1, %esi
               	movq	%rsi, %r9
               	andq	$0x1, %r9
               	movq	%r11, %rsi
               	orq	%r9, %rsi
               	movw	%si, (%rax)
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rsi
               	movq	%rsi, %rax
               	andq	$-0xf1, %rax
               	movl	$0xc, %esi
               	movq	%rsi, %r11
               	andq	$0xf, %r11
               	movq	%r11, %rsi
               	shlq	$0x4, %rsi
               	movq	%rax, %r11
               	orq	%rsi, %r11
               	movw	%r11w, (%r9)
               	leaq	-0x8(%rbp), %rsi
               	movzwq	(%rsi), %r11
               	movq	%r11, %r9
               	andq	$-0xff01, %r9           # imm = 0xFFFF00FF
               	movl	$0xc8, %r11d
               	movq	%r11, %rax
               	andq	$0xff, %rax
               	movq	%rax, %r11
               	shlq	$0x8, %r11
               	movq	%r9, %rax
               	orq	%r11, %rax
               	movw	%ax, (%rsi)
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %rax
               	movq	%rax, %rsi
               	andq	$-0xf, %rsi
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r9
               	movq	%r9, %rax
               	sarq	$0x1, %rax
               	movq	%rax, %r9
               	andq	$0x7, %r9
               	movq	%r9, %rax
               	xorq	$0x7, %rax
               	movq	%rax, %r9
               	andq	$0x7, %r9
               	movq	%r9, %rax
               	shlq	$0x1, %rax
               	movq	%rsi, %r9
               	orq	%rax, %r9
               	movw	%r9w, (%r11)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r9
               	movq	%r9, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	0x4005ff <.text+0x3df>
               	movl	$0xf, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	movq	%rax, %r9
               	sarq	$0x1, %r9
               	movq	%r9, %rax
               	andq	$0x7, %rax
               	cmpq	$0x6, %rax
               	je	0x400633 <.text+0x413>
               	movl	$0x10, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	movq	%rax, %r9
               	sarq	$0x4, %r9
               	movq	%r9, %rax
               	andq	$0xf, %rax
               	cmpq	$0xc, %rax
               	je	0x400667 <.text+0x447>
               	movl	$0x11, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	movq	%rax, %r9
               	sarq	$0x8, %r9
               	movq	%r9, %rax
               	andq	$0xff, %rax
               	cmpq	$0xc8, %rax
               	je	0x40069b <.text+0x47b>
               	movl	$0x12, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzwq	(%r9), %rax
               	movq	%rax, %r11
               	andq	$-0xf1, %r11
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rsi
               	movq	%rsi, %rax
               	sarq	$0x4, %rax
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	movq	%rsi, %rax
               	addq	$0x1, %rax
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	movq	%rsi, %rax
               	shlq	$0x4, %rax
               	movq	%r11, %rsi
               	orq	%rax, %rsi
               	movw	%si, (%r9)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rsi
               	movq	%rsi, %rax
               	sarq	$0x4, %rax
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	cmpq	$0xd, %rsi
               	je	0x400722 <.text+0x502>
               	movl	$0x13, %esi
               	movq	%rsi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rsi
               	movq	%rsi, %r9
               	andq	$-0xf1, %r9
               	leaq	-0x8(%rbp), %rsi
               	movzwq	(%rsi), %r11
               	movq	%r11, %rsi
               	sarq	$0x4, %rsi
               	movq	%rsi, %r11
               	andq	$0xf, %r11
               	movq	%r11, %rsi
               	subq	$0x4, %rsi
               	movq	%rsi, %r11
               	andq	$0xf, %r11
               	movq	%r11, %rsi
               	shlq	$0x4, %rsi
               	movq	%r9, %r11
               	orq	%rsi, %r11
               	movw	%r11w, (%rax)
               	leaq	-0x8(%rbp), %rsi
               	movzwq	(%rsi), %r11
               	movq	%r11, %rsi
               	sarq	$0x4, %rsi
               	movq	%rsi, %r11
               	andq	$0xf, %r11
               	cmpq	$0x9, %r11
               	je	0x4007a6 <.text+0x586>
               	movl	$0x14, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rsi
               	movzwq	(%rsi), %rax
               	movq	%rax, %r11
               	andq	$-0xff01, %r11          # imm = 0xFFFF00FF
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r9
               	movq	%r9, %rax
               	sarq	$0x8, %rax
               	movq	%rax, %r9
               	andq	$0xff, %r9
               	movq	%r9, %rax
               	shlq	$0x1, %rax
               	movq	%rax, %r9
               	andq	$0xff, %r9
               	movq	%r9, %rax
               	shlq	$0x8, %rax
               	movq	%r11, %r9
               	orq	%rax, %r9
               	movw	%r9w, (%rsi)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %r9
               	movq	%r9, %rax
               	sarq	$0x8, %rax
               	movq	%rax, %r9
               	andq	$0xff, %r9
               	movl	$0x190, %eax            # imm = 0x190
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%rax, %rsi
               	movl	$0x100, %eax            # imm = 0x100
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rdx, %rax
               	popq	%rdx
               	movq	%r9, %r11
               	xorq	%rax, %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40085e <.text+0x63e>
               	movl	$0x15, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movzwq	(%r11), %rax
               	movq	%rax, %r9
               	andq	$-0xf1, %r9
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rsi
               	movq	%rsi, %rax
               	sarq	$0x4, %rax
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	movq	%rsi, %rax
               	sarq	$0x2, %rax
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	movq	%rsi, %rax
               	shlq	$0x4, %rax
               	movq	%r9, %rsi
               	orq	%rax, %rsi
               	movw	%si, (%r11)
               	leaq	-0x8(%rbp), %rax
               	movzwq	(%rax), %rsi
               	movq	%rsi, %rax
               	sarq	$0x4, %rax
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	cmpq	$0x2, %rsi
               	je	0x4008e2 <.text+0x6c2>
               	movl	$0x16, %esi
               	movq	%rsi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
