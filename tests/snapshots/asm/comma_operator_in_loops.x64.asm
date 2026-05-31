
comma_operator_in_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003eb <.text+0x16b>
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
               	callq	0x400727 <dlsym>
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
               	movslq	%edi, %rax
               	leaq	0xfd6e(%rip), %r9       # 0x410148
               	movslq	(%r9), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movl	%edi, (%r9)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	0x400419 <.text+0x199>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0xa, %r8
               	movl	%r8d, (%r11)
               	jmp	0x400432 <.text+0x1b2>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %r9
               	cmpq	$0x0, %rbx
               	jne	0x400419 <.text+0x199>
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	cmpq	$0x0, %rbx
               	je	0x400488 <.text+0x208>
               	leaq	-0x10(%rbp), %r12
               	movslq	(%r12), %rbx
               	movq	%rbx, %r11
               	addq	$0x64, %r11
               	movl	%r11d, (%r12)
               	jmp	0x400488 <.text+0x208>
               	movl	$0x7, %r14d
               	movq	%r14, %rdi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %rbx
               	movl	$0x2, %ebx
               	jmp	0x4004f9 <.text+0x279>
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x8(%rbp)
               	jmp	0x400518 <.text+0x298>
               	leaq	-0x10(%rbp), %r14
               	movslq	(%r14), %r12
               	movq	%r12, %rbx
               	addq	$0x1, %rbx
               	movl	%ebx, (%r14)
               	jmp	0x4004a3 <.text+0x223>
               	leaq	-0x10(%rbp), %rbx
               	movslq	(%rbx), %r12
               	movq	%r12, %r14
               	addq	$0x3e8, %r14            # imm = 0x3E8
               	movl	%r14d, (%rbx)
               	jmp	0x4004a3 <.text+0x223>
               	leaq	-0x10(%rbp), %r14
               	movslq	(%r14), %r12
               	movq	%r12, %rbx
               	addq	$0x1869f, %rbx          # imm = 0x1869F
               	movl	%ebx, (%r14)
               	jmp	0x4004a3 <.text+0x223>
               	cmpq	$0x1, %rbx
               	je	0x4004ae <.text+0x22e>
               	cmpq	$0x2, %rbx
               	je	0x4004c7 <.text+0x247>
               	jmp	0x4004e0 <.text+0x260>
               	xorq	%r15, %r15
               	movq	%r15, %rdi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %r12
               	movslq	-0x8(%rbp), %r12
               	cmpq	$0x3, %r12
               	jge	0x400570 <.text+0x2f0>
               	jmp	0x400557 <.text+0x2d7>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x1, %r14
               	movl	%r14d, (%r12)
               	jmp	0x400518 <.text+0x298>
               	leaq	-0x10(%rbp), %r14
               	movslq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%r14)
               	jmp	0x40053c <.text+0x2bc>
               	leaq	0xfbd1(%rip), %r12      # 0x410148
               	movslq	(%r12), %r15
               	cmpq	$0x7, %r15
               	je	0x4005b0 <.text+0x330>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %r12
               	movq	%r12, %r15
               	subq	$0x456, %r15            # imm = 0x456
               	movslq	%r15d, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
