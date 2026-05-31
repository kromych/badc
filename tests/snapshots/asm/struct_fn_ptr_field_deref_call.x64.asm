
struct_fn_ptr_field_deref_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400259 <.text+0x39>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	addq	$0x3, %r9
               	movslq	%r9d, %rax
               	retq
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	addq	$0x7, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfe52(%rip), %rbx      # 0x4100d0
               	leaq	-0x4e(%rip), %r9        # 0x400237 <.text+0x17>
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
               	movq	%rax, %rbx
               	movslq	%r15d, %r14
               	cmpq	$0xd, %r14
               	je	0x4002fa <.text+0xda>
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
               	movslq	%ebx, %r15
               	cmpq	$0x17, %r15
               	je	0x400332 <.text+0x112>
               	movl	$0x2, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd97(%rip), %r12      # 0x4100d0
               	leaq	-0xf8(%rip), %r15       # 0x400248 <.text+0x28>
               	movq	%r15, (%r12)
               	movq	(%r12), %r14
               	movl	$0x64, %ebx
               	movq	%r14, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, %r15
               	movq	(%r12), %r14
               	movl	$0xc8, %ebx
               	movq	%r14, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, %r12
               	movslq	%r15d, %rbx
               	cmpq	$0x6b, %rbx
               	je	0x4003a5 <.text+0x185>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	%r12d, %r15
               	cmpq	$0xcf, %r15
               	je	0x4003dd <.text+0x1bd>
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
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
