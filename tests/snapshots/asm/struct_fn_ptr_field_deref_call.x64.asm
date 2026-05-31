
struct_fn_ptr_field_deref_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400253 <.text+0x33>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	addq	$0x3, %r11
               	movslq	%r11d, %rax
               	retq
               	movslq	%edi, %r11
               	addq	$0x7, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfe58(%rip), %rbx      # 0x4100d0
               	leaq	-0x48(%rip), %r9        # 0x400237 <.text+0x17>
               	movq	%r9, (%rbx)
               	movq	%rbx, %r8
               	addq	$0x8, %r8
               	xorq	%r9, %r9
               	movl	%r9d, (%r8)
               	movq	(%rbx), %r12
               	movl	$0xa, %r14d
               	movq	%r12, %r11
               	movq	%r14, %rdi
               	callq	*%r11
               	movq	%rax, %r15
               	movq	(%rbx), %r12
               	movl	$0x14, %r14d
               	movq	%r12, %r11
               	movq	%r14, %rdi
               	callq	*%r11
               	movslq	%r15d, %r15
               	cmpq	$0xd, %r15
               	je	0x4002f1 <.text+0xd1>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	cmpq	$0x17, %rax
               	je	0x400329 <.text+0x109>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfda0(%rip), %rbx      # 0x4100d0
               	leaq	-0xf2(%rip), %r14       # 0x400245 <.text+0x25>
               	movq	%r14, (%rbx)
               	movq	(%rbx), %r12
               	movl	$0x64, %r15d
               	movq	%r12, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	movq	%rax, %r14
               	movq	(%rbx), %r12
               	movl	$0xc8, %r15d
               	movq	%r12, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	movslq	%r14d, %r14
               	cmpq	$0x6b, %r14
               	je	0x400399 <.text+0x179>
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
               	movslq	%eax, %rax
               	cmpq	$0xcf, %rax
               	je	0x4003d1 <.text+0x1b1>
               	movl	$0x4, %r15d
               	movq	%r15, %rcx
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
               	addb	%al, 0x41(%rdx)
