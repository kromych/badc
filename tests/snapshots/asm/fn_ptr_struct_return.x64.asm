
fn_ptr_struct_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400252 <.text+0x22>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	movslq	%edi, %r11
               	leaq	0xfe8f(%rip), %rax      # 0x4100e0
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	leaq	0xfe6e(%rip), %r9       # 0x4100e8
               	movq	(%r9), %r12
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x4002bb <.text+0x8b>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe26(%rip), %r14      # 0x4100e8
               	movq	(%r14), %r15
               	xorq	%r12, %r12
               	movq	%r15, %r11
               	movq	%r12, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x400306 <.text+0xd6>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	(%r14), %rbx
               	xorq	%r15, %r15
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x40034a <.text+0x11a>
               	movl	$0x3, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10a(%rip), %r12      # 0x400247 <.text+0x17>
               	xorq	%r14, %r14
               	movq	%r12, %r11
               	movq	%r14, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x400392 <.text+0x162>
               	movl	$0x4, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x4003d2 <.text+0x1a2>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd0f(%rip), %rax      # 0x4100e8
               	movq	(%rax), %r14
               	xorq	%rbx, %rbx
               	movq	%r14, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	0x40041c <.text+0x1ec>
               	movl	$0x6, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
