
size_t_via_stdio.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40040a <.text+0x18a>
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
               	callq	0x4005b7 <dlsym>
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
               	movq	%rdi, %r11
               	leaq	0xfd88(%rip), %r11      # 0x410148
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	xorq	%rax, %rax
               	retq
               	movq	%rdi, %r11
               	leaq	0xfd6d(%rip), %r11      # 0x410148
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	xorq	%rax, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	leaq	0xfd4f(%rip), %r9       # 0x410148
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	callq	0x4003b6 <.text+0x136>
               	movl	$0x2, %r12d
               	movq	%r12, %rdi
               	callq	0x4003d1 <.text+0x151>
               	movl	$0x3, %ebx
               	movl	$0x4, %r14d
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	0x4003ec <.text+0x16c>
               	leaq	0xfced(%rip), %rax      # 0x410148
               	movslq	(%rax), %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
