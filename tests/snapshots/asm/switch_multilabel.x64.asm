
switch_multilabel.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002e7 <.text+0xc7>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	jmp	0x400260 <.text+0x40>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	retq
               	movl	$0x3, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	cmpq	$0x61, %r11
               	je	0x400243 <.text+0x23>
               	cmpq	$0x62, %r11
               	je	0x400243 <.text+0x23>
               	cmpq	$0x63, %r11
               	je	0x400243 <.text+0x23>
               	cmpq	$0x64, %r11
               	je	0x400243 <.text+0x23>
               	cmpq	$0x41, %r11
               	je	0x400249 <.text+0x29>
               	cmpq	$0x42, %r11
               	je	0x400249 <.text+0x29>
               	cmpq	$0x30, %r11
               	je	0x400253 <.text+0x33>
               	cmpq	$0x31, %r11
               	je	0x400253 <.text+0x33>
               	cmpq	$0x32, %r11
               	je	0x400253 <.text+0x33>
               	cmpq	$0x33, %r11
               	je	0x400253 <.text+0x33>
               	jmp	0x400259 <.text+0x39>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x61, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1, %rax
               	je	0x400332 <.text+0x112>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x62, %r12d
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1, %rax
               	je	0x40036b <.text+0x14b>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1, %rax
               	je	0x4003a2 <.text+0x182>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %r12d
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x1, %rax
               	je	0x4003db <.text+0x1bb>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x41, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x2, %rax
               	je	0x400412 <.text+0x1f2>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x42, %r12d
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x2, %rax
               	je	0x40044b <.text+0x22b>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x30, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x3, %rax
               	je	0x400482 <.text+0x262>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x33, %r12d
               	movq	%r12, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x3, %rax
               	je	0x4004bb <.text+0x29b>
               	movl	$0x8, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3f, %ebx
               	movq	%rbx, %rdi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	je	0x4004f2 <.text+0x2d2>
               	movl	$0x9, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
