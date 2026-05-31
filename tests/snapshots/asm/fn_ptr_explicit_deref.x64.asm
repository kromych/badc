
fn_ptr_explicit_deref.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400258 <.text+0x28>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100d0
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x36(%rip), %r11       # 0x400247 <.text+0x17>
               	movq	%r11, -0x8(%rbp)
               	movl	$0x28, %ebx
               	movq	-0x8(%rbp), %r12
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, %r8
               	cmpq	$0x29, %r8
               	je	0x4002cb <.text+0x9b>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x28, %r14d
               	movq	-0x8(%rbp), %r12
               	movq	%r12, %r11
               	movq	%r14, %rdi
               	callq	*%r11
               	movq	%rax, %rbx
               	cmpq	$0x29, %rbx
               	je	0x400315 <.text+0xe5>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r15
               	movq	(%r15), %r12
               	movl	$0x28, %ebx
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, %rdi
               	cmpq	$0x29, %rdi
               	je	0x400361 <.text+0x131>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	(%r15), %r14
               	movl	$0x28, %ebx
               	movq	%r14, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, %rdi
               	cmpq	$0x29, %rdi
               	je	0x4003a9 <.text+0x179>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
