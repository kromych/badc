
local_struct_array_brace_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002b7 <.text+0x97>
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
               	jge	0x4002aa <.text+0x8a>
               	jmp	0x400280 <.text+0x60>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	0x400258 <.text+0x38>
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %rsi
               	movslq	-0x10(%rbp), %rdi
               	shlq	$0x4, %rdi
               	movq	%r11, %rdx
               	addq	%rdi, %rdx
               	addq	$0x8, %rdx
               	movq	(%rdx), %rdi
               	addq	%rdi, %rsi
               	movq	%rsi, (%r8)
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
               	leaq	0xfe01(%rip), %r9       # 0x4100dc
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
               	je	0x400353 <.text+0x133>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
               	cmpq	$0x3, %r12
               	je	0x400390 <.text+0x170>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r12
               	addq	$0x28, %r12
               	movq	(%r12), %rax
               	cmpq	$0x5, %rax
               	je	0x4003cf <.text+0x1af>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	leaq	0xfd3e(%rip), %r12      # 0x41011b
               	pushq	%r11
               	movq	(%r12), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%r12), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%r12), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%r12), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%r12), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%r12), %r11
               	movq	%r11, 0x28(%rax)
               	popq	%r11
               	movq	%rax, %rbx
               	leaq	-0x40(%rbp), %rbx
               	leaq	-0x98(%rbp), %r12
               	movq	%rbx, (%r12)
               	movl	$0x10, %eax
               	leaq	-0x98(%rbp), %r12
               	addq	$0x8, %r12
               	movq	%rax, (%r12)
               	leaq	-0x60(%rbp), %rbx
               	leaq	-0x98(%rbp), %r12
               	addq	$0x10, %r12
               	movq	%rbx, (%r12)
               	movl	$0x20, %eax
               	leaq	-0x98(%rbp), %r12
               	addq	$0x18, %r12
               	movq	%rax, (%r12)
               	leaq	-0x68(%rbp), %rbx
               	leaq	-0x98(%rbp), %r12
               	addq	$0x20, %r12
               	movq	%rbx, (%r12)
               	movl	$0x8, %eax
               	leaq	-0x98(%rbp), %r12
               	addq	$0x28, %r12
               	movq	%rax, (%r12)
               	leaq	-0x98(%rbp), %r14
               	movl	$0x3, %ebx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x400237 <.text+0x17>
               	movl	$0x30, %ebx
               	movslq	%ebx, %rbx
               	addq	$0x8, %rbx
               	movslq	%ebx, %rbx
               	cmpq	%rbx, %rax
               	je	0x4004ec <.text+0x2cc>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rbx
               	leaq	-0x40(%rbp), %rax
               	cmpq	%rax, %rbx
               	je	0x400525 <.text+0x305>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rbx
               	addq	$0x10, %rbx
               	movq	(%rbx), %rax
               	leaq	-0x60(%rbp), %rbx
               	cmpq	%rbx, %rax
               	je	0x400565 <.text+0x345>
               	movl	$0x6, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rbx
               	leaq	-0x68(%rbp), %rax
               	cmpq	%rax, %rbx
               	je	0x4005a5 <.text+0x385>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rbx
               	addq	$0x28, %rbx
               	movq	(%rbx), %rax
               	cmpq	$0x8, %rax
               	je	0x4005e5 <.text+0x3c5>
               	movl	$0x8, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
