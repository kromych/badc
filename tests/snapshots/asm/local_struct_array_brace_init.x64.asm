
local_struct_array_brace_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002c3 <.text+0xa3>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	xorq	%r8, %r8
               	movq	%r8, -0x8(%rbp)
               	movl	%r8d, -0x10(%rbp)
               	jmp	0x400258 <.text+0x38>
               	movslq	-0x10(%rbp), %r8
               	cmpq	%r9, %r8
               	jge	0x4002b6 <.text+0x96>
               	jmp	0x400283 <.text+0x63>
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%r8)
               	jmp	0x400258 <.text+0x38>
               	leaq	-0x8(%rbp), %rsi
               	movq	(%rsi), %rdi
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %rdx
               	shlq	$0x4, %rdx
               	movq	%r11, %r8
               	addq	%rdx, %r8
               	movq	%r8, %rdx
               	addq	$0x8, %rdx
               	movq	(%rdx), %r8
               	movq	%rdi, %rdx
               	addq	%r8, %rdx
               	movq	%rdx, (%rsi)
               	jmp	0x40026a <.text+0x4a>
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	-0x30(%rbp), %r11
               	leaq	0xfdf5(%rip), %r9       # 0x4100dc
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	movq	0x8(%r9), %rax
               	movq	%rax, 0x8(%r11)
               	movq	0x10(%r9), %rax
               	movq	%rax, 0x10(%r11)
               	movq	0x18(%r9), %rax
               	movq	%rax, 0x18(%r11)
               	movq	0x20(%r9), %rax
               	movq	%rax, 0x20(%r11)
               	movq	0x28(%r9), %rax
               	movq	%rax, 0x28(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x30(%rbp), %rbx
               	movl	$0x3, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0xc, %rax
               	je	0x40035e <.text+0x13e>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
               	cmpq	$0x3, %r12
               	je	0x40039f <.text+0x17f>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x28, %r12
               	movq	(%r12), %rax
               	cmpq	$0x5, %rax
               	je	0x4003e0 <.text+0x1c0>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %r12
               	leaq	0xfd2d(%rip), %rax      # 0x41011b
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r12)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%r12)
               	movq	0x10(%rax), %r11
               	movq	%r11, 0x10(%r12)
               	movq	0x18(%rax), %r11
               	movq	%r11, 0x18(%r12)
               	movq	0x20(%rax), %r11
               	movq	%r11, 0x20(%r12)
               	movq	0x28(%rax), %r11
               	movq	%r11, 0x28(%r12)
               	popq	%r11
               	movq	%r12, %rbx
               	leaq	-0x40(%rbp), %rbx
               	leaq	-0x98(%rbp), %rax
               	movq	%rbx, (%rax)
               	movl	$0x10, %r12d
               	leaq	-0x98(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	%r12, (%rbx)
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x98(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0x10, %r12
               	movq	%rax, (%r12)
               	movl	$0x20, %ebx
               	leaq	-0x98(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x18, %rax
               	movq	%rbx, (%rax)
               	leaq	-0x68(%rbp), %r12
               	leaq	-0x98(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x20, %rbx
               	movq	%r12, (%rbx)
               	movl	$0x8, %eax
               	leaq	-0x98(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0x28, %r12
               	movq	%rax, (%r12)
               	leaq	-0x98(%rbp), %r14
               	movl	$0x3, %ebx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x400237 <.text+0x17>
               	movl	$0x30, %ebx
               	movslq	%ebx, %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movslq	%r14d, %r14
               	cmpq	%r14, %rax
               	je	0x40050d <.text+0x2ed>
               	movl	$0x4, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rbx
               	movq	(%rbx), %r14
               	leaq	-0x40(%rbp), %rbx
               	cmpq	%rbx, %r14
               	je	0x400546 <.text+0x326>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x10, %rbx
               	movq	(%rbx), %rax
               	leaq	-0x60(%rbp), %rbx
               	cmpq	%rbx, %rax
               	je	0x400589 <.text+0x369>
               	movl	$0x6, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %r14
               	movq	%r14, %rbx
               	addq	$0x20, %rbx
               	movq	(%rbx), %r14
               	leaq	-0x68(%rbp), %rbx
               	cmpq	%rbx, %r14
               	je	0x4005cc <.text+0x3ac>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x28, %rbx
               	movq	(%rbx), %rax
               	cmpq	$0x8, %rax
               	je	0x40060f <.text+0x3ef>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
