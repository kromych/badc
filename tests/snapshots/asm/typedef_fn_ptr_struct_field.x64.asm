
typedef_fn_ptr_struct_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400245 <.text+0x25>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	imulq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x10(%rbp), %r11
               	leaq	-0x37(%rip), %r9        # 0x400237 <.text+0x17>
               	movq	%r9, (%r11)
               	leaq	-0x10(%rbp), %r8
               	addq	$0x8, %r8
               	xorq	%r9, %r9
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %rbx
               	movq	(%rbx), %r12
               	movl	$0x3, %r14d
               	movl	$0x7, %r15d
               	movq	%r12, %r11
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	*%r11
               	cmpq	$0x15, %rax
               	je	0x4002d6 <.text+0xb6>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %r12
               	movl	$0x4, %r14d
               	movl	$0x5, %ebx
               	movq	%r12, %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	cmpq	$0x14, %rax
               	je	0x400324 <.text+0x104>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r15
               	movl	$0x2, %ebx
               	movl	$0x9, %r12d
               	movq	%r15, %r11
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	*%r11
               	cmpq	$0x12, %rax
               	je	0x400377 <.text+0x157>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r14
               	movl	$0x6, %r12d
               	movl	$0x4, %r15d
               	movq	%r14, %r11
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	callq	*%r11
               	cmpq	$0x18, %rax
               	je	0x4003cb <.text+0x1ab>
               	movl	$0x4, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
