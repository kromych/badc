
struct_field_enum_type.x64:	file format elf64-x86-64

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
               	callq	0x4005f7 <dlsym>
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %r11
               	movl	$0x5, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x1, %r9d
               	movl	%r9d, (%r8)
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	cmpq	$0x5, %r9
               	je	0x400404 <.text+0x184>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x1, %rax
               	je	0x400431 <.text+0x1b1>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %r9d
               	movl	%r9d, (%rax)
               	leaq	-0x10(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x7, %r9d
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r9
               	cmpq	$0x1, %r9
               	je	0x400474 <.text+0x1f4>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x7, %rax
               	je	0x4004a1 <.text+0x221>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xd, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
