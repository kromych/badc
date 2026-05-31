
typedef_fn_ptr_struct_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400248 <.text+0x28>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	imulq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x10(%rbp), %r11
               	leaq	-0x3a(%rip), %r9        # 0x400237 <.text+0x17>
               	movq	%r9, (%r11)
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x8, %r9
               	xorq	%r8, %r8
               	movl	%r8d, (%r9)
               	leaq	-0x10(%rbp), %rbx
               	movq	(%rbx), %r12
               	movl	$0x3, %r14d
               	movl	$0x7, %r15d
               	movq	%r12, %r11
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	*%r11
               	cmpq	$0x15, %rax
               	je	0x4002db <.text+0xbb>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %r12
               	movl	$0x4, %r15d
               	movl	$0x5, %ebx
               	movq	%r12, %r11
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	cmpq	$0x14, %rax
               	je	0x400329 <.text+0x109>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rbx
               	movq	(%rbx), %r14
               	movl	$0x2, %r12d
               	movl	$0x9, %ebx
               	movq	%r14, %r11
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	cmpq	$0x12, %rax
               	je	0x40037b <.text+0x15b>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rbx
               	movq	(%rbx), %r15
               	movl	$0x6, %r14d
               	movl	$0x4, %ebx
               	movq	%r15, %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	cmpq	$0x18, %rax
               	je	0x4003cd <.text+0x1ad>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
